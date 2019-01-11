//
//  UserController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 10/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit

class UserController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbDias: UILabel!
    @IBOutlet weak var lbVencimento: UILabel!
    @IBOutlet weak var lbPlano: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbCPF: UILabel!
    @IBOutlet weak var lbIdade: UILabel!
    @IBOutlet weak var lbNascimento: UILabel!
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var logoH: NSLayoutConstraint!
    @IBOutlet weak var logoW: NSLayoutConstraint!
    @IBOutlet weak var list1: UITableView!
    @IBOutlet weak var lbParcelas: UILabel!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parcela.parcela.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "Data: " + parcela.getParc(indexPath.row).data + " Valor: " +  parcela.getParc(indexPath.row).valor
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbNome.text = "Nome: " + myAluno.Nome
        lbNascimento.text = "Nascimento: " + myAluno.Nascimento
        lbIdade.text = "Idade: " + String(myAluno.idade)
        lbCPF.text = "CPF: " + myAluno.CPF
        lbEmail.text = "E-mail: " + myAluno.email
        lbPlano.text = "Plano: " + myAluno.plano
        lbVencimento.text = "Vencimento: " + myAluno.proxvenc
        montaVencimento()
        if myAluno.foto.count>10{
           imgFoto.image = base64ImgFromString(myAluno.foto)
           imgFoto.isHidden = false
        }else{
           imgFoto.isHidden = true
        }
        list1.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        let noShow = (parcela.parcela.count==0)
        list1.isHidden = noShow
        lbParcelas.isHidden = noShow
    }
    
    func montaVencimento(){
        lbVencimento.textColor = UIColor.white
        lbDias.textColor = UIColor.white
        if myAluno.Status == 1 {
            lbVencimento.text = "Aluno sem pagamentos"
            lbVencimento.textColor = UIColor.red
            lbDias.isHidden = true
        }
        if myAluno.Status == 5 {
            lbVencimento.text = "Vencimento: " + myAluno.proxvenc + ", TRANCADO"
            lbVencimento.textColor = UIColor.yellow
            lbDias.isHidden = true
        }
        if myAluno.Status == 4 {
            lbVencimento.text = "Vencimento: " + myAluno.proxvenc + ", DESISTENTE"
            lbVencimento.textColor = UIColor.red
            lbDias.isHidden = true
        }
        if myAluno.Status == 2 {
            if myAluno.plano.lowercased().contains("bolsista")==false{
                lbVencimento.text = "Vencimento: " + myAluno.proxvenc + ", em dia"
                lbDias.text = "Dias para terminar o plano: " + String(myAluno.atraso * -1)
            }else{
                lbVencimento.text = "Vencimento: " + myAluno.proxvenc
                lbDias.text = "Dias para terminar a bolsa: " + String(myAluno.atraso * -1)
            }
            lbDias.isHidden = false
            lbVencimento.textColor = UIColor.green
        }
        if myAluno.Status == 3 {
            if myAluno.atraso > myAluno.tolerancia {
                lbVencimento.text = "Vencimento: " + myAluno.proxvenc + ", inadimplente"
                lbDias.isHidden = false
                lbDias.text = "Atraso: " + String(myAluno.atraso) + " dias. Tolerância: " + String(myAluno.tolerancia) + " dias."
                lbDias.textColor = UIColor.red
                lbVencimento.textColor = UIColor.red
            }else{
                lbVencimento.text = "Vencimento: " + myAluno.proxvenc + ", atrasado"
                lbDias.isHidden = false
            }
            if myAluno.atraso == 1 {
                lbDias.text = "Atraso: " + String(myAluno.atraso) + " dia. Tolerância: " + String(myAluno.tolerancia) + " dias."
            }else{
                lbDias.text = "Atraso: " + String(myAluno.atraso) + " dias. Tolerância: " + String(myAluno.tolerancia) + " dias."
            }
            lbDias.textColor = UIColor.yellow
            lbVencimento.textColor = UIColor.yellow
        }
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

