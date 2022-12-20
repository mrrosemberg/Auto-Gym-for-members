//
//  AeroController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 23/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit

import SwiftyJSON

class AeroController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btnSeg: UIButton!
    @IBOutlet weak var btnTer: UIButton!
    @IBOutlet weak var btnQua: UIButton!
    @IBOutlet weak var btnQui: UIButton!
    @IBOutlet weak var btnSex: UIButton!
    @IBOutlet weak var btnSab: UIButton!
    @IBOutlet weak var btnDom: UIButton!
    @IBOutlet weak var list1: UITableView!
    @IBOutlet weak var lbTitle: UILabel!
    
    var aeroData = ListaSecao([lista("Dados do Aluno",[linha("Nome: "+myAluno.Nome)])])
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return aeroData.elemento.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return aeroData.elemento[section].section
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.gray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return aero.exercicios.count
        return aeroData.elemento[section].linhas.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = aeroData.elemento[indexPath.section].linhas[indexPath.row].text
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.font = UIFont.init(name: "System", size: 15)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.montaAero()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        list1.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
    }
    
    func allRegular(){
        let seg = (aero.header.diaourotina=="rotina" ? "RtA" : "Seg")
        let ter = (aero.header.diaourotina=="rotina" ? "RtB" : "Ter")
        let qua = (aero.header.diaourotina=="rotina" ? "RtC" : "Qua")
        let qui = (aero.header.diaourotina=="rotina" ? "RtD" : "Qui")
        let sex = (aero.header.diaourotina=="rotina" ? "RtE" : "Sex")
        let sab = (aero.header.diaourotina=="rotina" ? "RtF" : "Sab")
        let dom = (aero.header.diaourotina=="rotina" ? "RtG" : "Dom")
        
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.backgroundColor : UIColor.clear]
        var attributeString = NSMutableAttributedString(string: seg,                                               attributes: yourAttributes)
        
        btnSeg.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: ter,                                               attributes: yourAttributes)
        btnTer.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: qua,                                               attributes: yourAttributes)
        btnQua.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: qui,                                               attributes: yourAttributes)
        btnQui.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: sex,                                               attributes: yourAttributes)
        btnSex.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: sab,                                               attributes: yourAttributes)
        btnSab.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: dom,                                               attributes: yourAttributes)
        btnDom.setAttributedTitle(attributeString, for: .normal)
    }
    
    func boldAndUnderlineButtom(_ btn:UIButton){
        let txt = btn.titleLabel?.text
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.backgroundColor : UIColor.clear,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: txt!,
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
    }
    
    @IBAction func btnSegClick(_ sender: Any) {
        loadDiaRotina(2)
    }
    @IBAction func btnTerClick(_ sender: Any) {
        loadDiaRotina(3)
    }
    @IBAction func btnQuaClick(_ sender: Any) {
        loadDiaRotina(4)
    }
    @IBAction func btnQuiClick(_ sender: Any) {
        loadDiaRotina(5)
    }
    @IBAction func btnSexClick(_ sender: Any) {
        loadDiaRotina(6)
    }
    @IBAction func btnSabClick(_ sender: Any) {
        loadDiaRotina(7)
    }
    @IBAction func btnDomClick(_ sender: Any) {
        loadDiaRotina(1)
    }
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func montaAero(){
        aero.clear()
        if rawAero.isEmpty{
            return
        }
        guard let json = try? JSON(data: rawAero.data(using: .utf8)!) else {return}
        aero.header.diaourotina = json["diaourotina"].stringValue
        aero.header.fim = json["fim"].stringValue
        aero.header.idade = json["idade"].intValue
        aero.header.inicio = json["inicio"].stringValue
        aero.header.nivel = json["nivel"].stringValue.lowercased()
        aero.header.obs = json["obs"].stringValue.lowercased()
        aero.header.professor = json["professor"].stringValue
        aero.header.aeronum = json["aeronum"].intValue
        aero.header.qtdimp = json["qtdimp"].intValue
        aero.header.rotina = json["rotina"].stringValue
        aero.header.ultimp = json["ultimp"].stringValue
        aero.header.zonaalvo = json["zonaalvo"].stringValue
        if aero.header.diaourotina.lowercased() == "rotina"{
            lbTitle.text = "Rotinas do Programa Aeróbio"
        }else{
            lbTitle.text = "Séries do Programa Aeróbio"
        }
        var aux = "Programa: " + String(aero.header.aeronum)
        aeroData = ListaSecao([lista("Cabeçalho do Programa",[linha(aux)])])
        aux = "Validade: " + aero.header.inicio + " a " + aero.header.fim
        aeroData.elemento[0].linhas.append(linha(aux))
        aux = "Nível: " + aero.header.nivel
        aeroData.elemento[0].linhas.append(linha(aux))
        aux = "Zona Alvo: " + aero.header.zonaalvo
        aeroData.elemento[0].linhas.append(linha(aux))
        aux = "Professor: " + aero.header.professor
        aeroData.elemento[0].linhas.append(linha(aux))
        aux = "Qtd. Acessos: " + String(aero.header.qtdimp)
        aeroData.elemento[0].linhas.append(linha(aux))
        aux = "Último Acesso: " + aero.header.ultimp
        aeroData.elemento[0].linhas.append(linha(aux))
        aux = "Obs.: " + aero.header.obs
        aeroData.elemento[0].linhas.append(linha(aux))
        let dict = json["lista"].dictionaryValue
        let list = dict["rows"]!.arrayValue
        for item in list{
            let ex = ExAero()
            ex.fc = item["fc"].stringValue
            ex.exbio = item["exbio"].stringValue.lowercased()
            ex.regulagem = item["regulagem"].stringValue
            ex.tempo = item["tempo"].stringValue
            ex.borg = item["borg"].stringValue
            ex.seq = item["seq"].intValue
            ex.domingo = item["domingo"].boolValue
            ex.segunda = item["segunda"].boolValue
            ex.terca = item["terca"].boolValue
            ex.quarta = item["quarta"].boolValue
            ex.quinta = item["quinta"].boolValue
            ex.sexta = item["sexta"].boolValue
            ex.sabado = item["sabado"].boolValue
            aero.addExercicio(ex)
        }
        btnSeg.isHidden = true
        btnTer.isHidden = true
        btnQua.isHidden = true
        btnQui.isHidden = true
        btnSex.isHidden = true
        btnSab.isHidden = true
        btnDom.isHidden = true
        for item in aero.exercicios{
            if item.domingo{
                btnDom.isHidden = false
            }
            if item.segunda{
                btnSeg.isHidden = false
            }
            if item.terca{
                btnTer.isHidden = false
            }
            if item.quarta{
                btnQua.isHidden = false
            }
            if item.quinta{
                btnQui.isHidden = false
            }
            if item.sexta{
                btnSex.isHidden = false
            }
            if item.sabado{
                btnSab.isHidden = false
            }
            if btnDom.isHidden==false && btnSeg.isHidden==false && btnTer.isHidden==false && btnQua.isHidden==false && btnQui.isHidden==false && btnSex.isHidden==false && btnSab.isHidden==false{
                break
            }
        }
        let myCalendar = Calendar(identifier: .gregorian)
        var dia = myCalendar.component(.weekday, from: Date())
        if aero.header.diaourotina=="rotina"{
            dia = 0
        }
        self.loadDiaRotina(dia)
    }
    
    func loadDiaRotina(_ dia:Int){
        var dia = dia
        if dia==0{
            if aero.header.rotina.uppercased()=="A"{
                dia=2
            }
            if aero.header.rotina.uppercased()=="B"{
                dia=3
            }
            if aero.header.rotina.uppercased()=="C"{
                dia=4
            }
            if aero.header.rotina.uppercased()=="D"{
                dia=5
            }
            if aero.header.rotina.uppercased()=="E"{
                dia=6
            }
            if aero.header.rotina.uppercased()=="F"{
                dia=7
            }
            if aero.header.rotina.uppercased()=="G"{
                dia=1
            }
        }
        
        allRegular()
        if dia==2 {
            boldAndUnderlineButtom(btnSeg)
        }
        if dia==3 {
            boldAndUnderlineButtom(btnTer)
        }
        if dia==4 {
            boldAndUnderlineButtom(btnQua)
        }
        if dia==5 {
            boldAndUnderlineButtom(btnQui)
        }
        if dia==6 {
            boldAndUnderlineButtom(btnSex)
        }
        if dia==7 {
            boldAndUnderlineButtom(btnSab)
        }
        if dia==1 {
            boldAndUnderlineButtom(btnDom)
        }
        aero.header.dia = dia
        performSegue(withIdentifier: "AeroDetailController", sender: nil)
    }
    
}
