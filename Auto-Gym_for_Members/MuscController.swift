//
//  MuscController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 21/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit

import SwiftyJSON

class MuscController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btnSeg: UIButton!
    @IBOutlet weak var btnTer: UIButton!
    @IBOutlet weak var btnQua: UIButton!
    @IBOutlet weak var btnQui: UIButton!
    @IBOutlet weak var btnSex: UIButton!
    @IBOutlet weak var btnSab: UIButton!
    @IBOutlet weak var btnDom: UIButton!
    @IBOutlet weak var list1: UITableView!
    @IBOutlet weak var lbTitle: UILabel!
    
    var serieData = ListaSecao([lista("Dados do Aluno",[linha("Nome: "+myAluno.Nome)])])
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return serieData.elemento.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return serieData.elemento[section].section
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return serie.exercicios.count
        return serieData.elemento[section].linhas.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = serieData.elemento[indexPath.section].linhas[indexPath.row].text
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
        self.montaSerie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        list1.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
    }
    
    func allRegular(){
        let seg = (serie.header.diaourotina=="rotina" ? "RtA" : "Seg")
        let ter = (serie.header.diaourotina=="rotina" ? "RtB" : "Ter")
        let qua = (serie.header.diaourotina=="rotina" ? "RtC" : "Qua")
        let qui = (serie.header.diaourotina=="rotina" ? "RtD" : "Qui")
        let sex = (serie.header.diaourotina=="rotina" ? "RtE" : "Sex")
        let sab = (serie.header.diaourotina=="rotina" ? "RtF" : "Sab")
        let dom = (serie.header.diaourotina=="rotina" ? "RtG" : "Dom")
        
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
    
    func montaSerie(){
        serie.clear()
        if rawSerie.isEmpty{
            return
        }
        guard let json = try? JSON(data: rawSerie.data(using: .utf8)!) else {return}
        serie.header.diaourotina = json["diaourotina"].stringValue
        serie.header.fim = json["fim"].stringValue
        serie.header.idade = json["idade"].intValue
        serie.header.inicio = json["inicio"].stringValue
        serie.header.nivel = json["nivel"].stringValue.lowercased()
        serie.header.obs = json["obs"].stringValue.lowercased()
        serie.header.professor = json["professor"].stringValue
        serie.header.programanum = json["programanum"].intValue
        serie.header.qtdimp = json["qtdimp"].intValue
        serie.header.rotina = json["rotina"].stringValue
        serie.header.tserie = json["tserie"].stringValue.lowercased()
        serie.header.ultimp = json["ultimp"].stringValue
        if serie.header.diaourotina.lowercased() == "rotina"{
            lbTitle.text = "Rotinas do Programa de Musculação"
        }else{
            lbTitle.text = "Séries do Programa de Musculação"
        }
        var aux = "Programa: " + String(serie.header.programanum)
        serieData = ListaSecao([lista("Cabeçalho do Programa",[linha(aux)])])
        aux = "Validade: " + serie.header.inicio + " a " + serie.header.fim
        serieData.elemento[0].linhas.append(linha(aux))
        aux = "Nível: " + serie.header.nivel
        serieData.elemento[0].linhas.append(linha(aux))
        aux = "Tipo de Série: " + serie.header.tserie
        serieData.elemento[0].linhas.append(linha(aux))
        aux = "Professor: " + serie.header.professor
        serieData.elemento[0].linhas.append(linha(aux))
        aux = "Qtd. Acessos: " + String(serie.header.qtdimp)
        serieData.elemento[0].linhas.append(linha(aux))
        aux = "Último Acesso: " + serie.header.ultimp
        serieData.elemento[0].linhas.append(linha(aux))
        aux = "Obs.: " + serie.header.obs
        serieData.elemento[0].linhas.append(linha(aux))
        let dict = json["lista"].dictionaryValue
        let list = dict["rows"]!.arrayValue
        for item in list{
            let ex = Exercicio()
            ex.carga = item["carga"].stringValue
            ex.exercicio = item["exercicio"].stringValue.lowercased()
            ex.regiao = item["regiao"].stringValue.lowercased()
            ex.regulagem = item["regulagem"].stringValue
            ex.repeticoes = item["repeticoes"].stringValue
            ex.series = item["series"].stringValue
            ex.seq = item["seq"].intValue
            ex.domingo = item["domingo"].boolValue
            ex.segunda = item["segunda"].boolValue
            ex.terca = item["terca"].boolValue
            ex.quarta = item["quarta"].boolValue
            ex.quinta = item["quinta"].boolValue
            ex.sexta = item["sexta"].boolValue
            ex.sabado = item["sabado"].boolValue
            serie.addExercicio(ex)
        }
        btnSeg.isHidden = true
        btnTer.isHidden = true
        btnQua.isHidden = true
        btnQui.isHidden = true
        btnSex.isHidden = true
        btnSab.isHidden = true
        btnDom.isHidden = true
        for item in serie.exercicios{
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
        self.loadDiaRotina(0)
    }
    
    func loadDiaRotina(_ dia:Int){
        var dia = dia
        //print("Parâmento dia: "+String(dia))
        if dia==0{
            if serie.header.diaourotina=="rotina"{
                if serie.header.rotina.uppercased()=="A"{
                    dia=2
                }
                if serie.header.rotina.uppercased()=="B"{
                    dia=3
                }
                if serie.header.rotina.uppercased()=="C"{
                    dia=4
                }
                if serie.header.rotina.uppercased()=="D"{
                    dia=5
                }
                if serie.header.rotina.uppercased()=="E"{
                    dia=6
                }
                if serie.header.rotina.uppercased()=="F"{
                    dia=7
                }
                if serie.header.rotina.uppercased()=="G"{
                    dia=1
                }
            }else{
                let myCalendar = Calendar(identifier: .gregorian)
                dia = myCalendar.component(.weekday, from: Date())
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
        serie.header.dia = dia
        //print("serie.header.dia: "+String(serie.header.dia))
        performSegue(withIdentifier: "MuscDetailController", sender: nil)
    }
    
}
