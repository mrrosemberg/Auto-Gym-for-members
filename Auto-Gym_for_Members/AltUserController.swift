//
//  AltUserController.swift
//  Auto-Gym_for_Members
//  Displays Member data
//  Created by Marcio R. Rosemberg on 15/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//  Last Update: 21/12/2022

import Foundation
import UIKit

class AltUserController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var list1: UITableView!
    
    var alData = ListaSecao([lista("Dados do Aluno",[linha("Nome: "+myAluno.Nome)])])
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return alData.elemento.count
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.gray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alData.elemento[section].linhas.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return alData.elemento[section].section
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        // TODO cell como especificar a seção.
        cell.textLabel?.text = self.alData.elemento[indexPath.section].linhas[indexPath.row].text
        cell.textLabel?.textColor = self.alData.elemento[indexPath.section].linhas[indexPath.row].color
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alData = ListaSecao([lista("Dados do Aluno",[linha("Nome: "+myAluno.Nome)])])
        self.alData.elemento[0].linhas.append(linha("Nascimento: " + myAluno.Nascimento))
        self.alData.elemento[0].linhas.append(linha("Idade: " + String(myAluno.idade)))
        self.alData.elemento[0].linhas.append(linha("CPF: " + myAluno.CPF))
        self.alData.elemento[0].linhas.append(linha("E-mail: " + myAluno.email))
        self.alData.elemento[0].linhas.append(linha("Plano: " + myAluno.plano))
        montaVencimento()
        if parcela.parcela.count>0 && myAluno.plano.lowercased().contains("bolsista")==false {
           alData.addLinha(lista("Parcelas do Plano",[linha("Data: " + parcela.getParc(0).data + " Valor: " +  parcela.getParc(0).valor)]))
            if parcela.parcela.count>1{
                for i in 1 ... parcela.parcela.count-1 {
                    alData.elemento[1].linhas.append(linha("Data: " + parcela.getParc(i).data + " Valor: " +  parcela.getParc(i).valor))
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if myAluno.foto.count>10{
            imgFoto.image = base64ImgFromString(myAluno.foto)
            imgFoto.isHidden = false
        }else{
            imgFoto.isHidden = true
        }
        list1.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        //let noShow = (parcela.parcela.count==0)
        //list1.isHidden = noShow
        //lbParcelas.isHidden = noShow
    }
    
    func montaVencimento(){
        if myAluno.Status == 1 {
             self.alData.elemento[0].linhas.append(linha(UIColor.red,"Aluno sem pagamentos"))
        }
        if myAluno.Status == 5 {
            self.alData.elemento[0].linhas.append(linha(UIColor.yellow,"Vencimento: " + myAluno.proxvenc + ", TRANCADO"))
        }
        if myAluno.Status == 4 {
            self.alData.elemento[0].linhas.append(linha(UIColor.red,"Vencimento: " + myAluno.proxvenc + ", DESISTENTE"))
        }
        if myAluno.Status == 2 {
            if myAluno.plano.lowercased().contains("bolsista")==false{
                self.alData.elemento[0].linhas.append(linha(UIColor.green,"Vencimento: " + myAluno.proxvenc + ", em dia"))
                self.alData.elemento[0].linhas.append(linha("Dias para terminar o plano: " + String(myAluno.atraso * -1)))
            }else{
                self.alData.elemento[0].linhas.append(linha(UIColor.green,"Vencimento: " + myAluno.proxvenc))
                self.alData.elemento[0].linhas.append(linha("Dias para terminar a bolsa: " + String(myAluno.atraso * -1)))
            }
        }
        if myAluno.Status == 3 {
            if myAluno.atraso > myAluno.tolerancia {
                self.alData.elemento[0].linhas.append(linha(UIColor.red,"Vencimento: " + myAluno.proxvenc + ", inadimplente"))
                self.alData.elemento[0].linhas.append(linha(UIColor.red,"Atraso: " + String(myAluno.atraso) + " dias. Tolerância: " + String(myAluno.tolerancia) + " dias."))
            }else{
                self.alData.elemento[0].linhas.append(linha(UIColor.yellow,"Vencimento: " + myAluno.proxvenc + ", atrasado"))
            }
            if myAluno.atraso == 1 {
                self.alData.elemento[0].linhas.append(linha(UIColor.yellow,"Atraso: " + String(myAluno.atraso) + " dia. Tolerância: " + String(myAluno.tolerancia) + " dias."))
            }else{
                self.alData.elemento[0].linhas.append(linha(UIColor.yellow,"Atraso: " + String(myAluno.atraso) + " dias. Tolerância: " + String(myAluno.tolerancia) + " dias."))
            }
        }
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
