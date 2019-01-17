//
//  TurmaController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 17/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit

class TurmaController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btnSeg: UIButton!
    @IBOutlet weak var btnTer: UIButton!
    @IBOutlet weak var btnQua: UIButton!
    @IBOutlet weak var btnQui: UIButton!
    @IBOutlet weak var btnSex: UIButton!
    @IBOutlet weak var btnSab: UIButton!
    @IBOutlet weak var btnDom: UIButton!
    @IBOutlet weak var list1: UITableView!
    var alData = ListaAluno([lista("Dados do Aluno",[linha("Nome: "+myAluno.Nome)])])
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return alData.elemento.count
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
        cell.textLabel?.text = alData.elemento[indexPath.section].linhas[indexPath.row].text
        cell.textLabel?.textColor = alData.elemento[indexPath.section].linhas[indexPath.row].color
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alData.elemento[0].linhas.append(linha("Nascimento: " + myAluno.Nascimento))
        self.alData.elemento[0].linhas.append(linha("Idade: " + String(myAluno.idade)))
        self.alData.elemento[0].linhas.append(linha("CPF: " + myAluno.CPF))
        self.alData.elemento[0].linhas.append(linha("E-mail: " + myAluno.email))
        self.alData.elemento[0].linhas.append(linha("Plano: " + myAluno.plano))
        if parcela.parcela.count>0{
            alData.addLinha(lista("Parcelas do Plano",[linha("Data: " + parcela.getParc(0).data + " Valor: " +  parcela.getParc(0).valor)]))
            for i in 1 ... parcela.parcela.count-1 {
                alData.elemento[1].linhas.append(linha("Data: " + parcela.getParc(i).data + " Valor: " +  parcela.getParc(i).valor))
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        list1.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
    }
    
    func allRegular(){
        btnSeg.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnTer.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnQua.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnQui.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnSex.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnSab.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnDom.titleLabel?.font = UIFont.init(name: "System", size: 15)
    }
    
    @IBAction func btnSegClick(_ sender: Any) {
        allRegular()
        btnSeg.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    @IBAction func btnTerClick(_ sender: Any) {
        allRegular()
        btnTer.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    @IBAction func btnQuaClick(_ sender: Any) {
        allRegular()
        btnQua.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    @IBAction func btnQuiClick(_ sender: Any) {
        allRegular()
        btnQui.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    @IBAction func btnSexClick(_ sender: Any) {
        allRegular()
        btnSex.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    @IBAction func btnSabClick(_ sender: Any) {
        allRegular()
        btnSab.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    @IBAction func btnDomClick(_ sender: Any) {
        allRegular()
        btnDom.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
