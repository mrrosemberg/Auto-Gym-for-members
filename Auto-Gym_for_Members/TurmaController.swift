//
//  TurmaController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 17/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class TurmaController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btnSeg: UIButton!
    @IBOutlet weak var btnTer: UIButton!
    @IBOutlet weak var btnQua: UIButton!
    @IBOutlet weak var btnQui: UIButton!
    @IBOutlet weak var btnSex: UIButton!
    @IBOutlet weak var btnSab: UIButton!
    @IBOutlet weak var btnDom: UIButton!
    @IBOutlet weak var list1: UITableView!
    var turmaData = Turmas([Turma("", "", "", "", "", "", false)])
    var firstTime = true
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return turmaData.turma.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        let pointer = indexPath.row
        cell.textLabel?.text = "Horário: " + turmaData.turma[pointer].inicio + " Professor: " + turmaData.turma[pointer].professor
        cell.detailTextLabel?.text = "Atividade: " + turmaData.turma[pointer].atividade + ". Sala: " + turmaData.turma[pointer].sala
        cell.detailTextLabel?.font = UIFont.init(name: "System", size: 15)
        cell.textLabel?.font = UIFont.init(name: "System", size: 15)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        turmaDetail = ListaSecao([lista("Detalhes da Turma",[linha("Turma: "+turmaData.turma[indexPath.row].turma)])])
        turmaDetail.elemento[0].linhas.append(linha("Horário: de " + turmaData.turma[indexPath.row].inicio + " até " + turmaData.turma[indexPath.row].fim))
        turmaDetail.elemento[0].linhas.append(linha("Atividade: " + turmaData.turma[indexPath.row].atividade))
        turmaDetail.elemento[0].linhas.append(linha("Professor: " + turmaData.turma[indexPath.row].professor))
        turmaDetail.elemento[0].linhas.append(linha("Sala: " + turmaData.turma[indexPath.row].sala))
        if turmaData.turma[indexPath.row].matriculado{
            turmaDetail.elemento[0].linhas.append(linha(UIColor.green, "Você está matriculado neste atividade"))
        }else{
            turmaDetail.elemento[0].linhas.append(linha(UIColor.red, "Você não está matriculado neste atividade"))
        }
        performSegue(withIdentifier: "TurmaDetailController", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTurmas(0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        list1.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.turmaData.turma.count<1 && self.firstTime{
            _ = warning(view: self, title: "Aviso", message: "Não há turmas para o dia de hoje", buttons: 1)
        }
    }
    
    func allRegular(){
        /*btnSeg.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnTer.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnQua.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnQui.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnSex.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnSab.titleLabel?.font = UIFont.init(name: "System", size: 15)
        btnDom.titleLabel?.font = UIFont.init(name: "System", size: 15)*/
        
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.backgroundColor : UIColor.clear]
        var attributeString = NSMutableAttributedString(string: "Seg",                                               attributes: yourAttributes)
        
        btnSeg.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: "Ter",                                               attributes: yourAttributes)
        btnTer.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: "Qua",                                               attributes: yourAttributes)
        btnQua.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: "Qui",                                               attributes: yourAttributes)
        btnQui.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: "Sex",                                               attributes: yourAttributes)
        btnSex.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: "Sab",                                               attributes: yourAttributes)
        btnSab.setAttributedTitle(attributeString, for: .normal)
        attributeString = NSMutableAttributedString(string: "Dom",                                               attributes: yourAttributes)
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
        loadTurmas(2)
    }
    @IBAction func btnTerClick(_ sender: Any) {
        loadTurmas(3)
    }
    @IBAction func btnQuaClick(_ sender: Any) {
        loadTurmas(4)
    }
    @IBAction func btnQuiClick(_ sender: Any) {
        loadTurmas(5)
    }
    @IBAction func btnSexClick(_ sender: Any) {
        loadTurmas(6)
    }
    @IBAction func btnSabClick(_ sender: Any) {
        loadTurmas(7)
    }
    @IBAction func btnDomClick(_ sender: Any) {
        loadTurmas(1)
    }
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadTurmas(_ dia:Int){
        turmaData.clear()
        var dia = dia
        self.firstTime = dia==0 ? true : false
        if rawTurmas.isEmpty==false{
            guard let json = try? JSON(data: rawTurmas.data(using: .utf8)!) else {return}
            turmaData.dayOfWeek = json["dayofweek"].stringValue
            allRegular()
            if dia==2 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("seg")){
                dia = 2
                boldAndUnderlineButtom(btnSeg)
            }
            if dia==3 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("ter")){
                dia = 3
                boldAndUnderlineButtom(btnTer)
            }
            if dia==4 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("qua")){
                dia = 4
                boldAndUnderlineButtom(btnQua)
            }
            if dia==5 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("qui")){
                dia = 5
                boldAndUnderlineButtom(btnQui)
            }
            if dia==6 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("sex")){
                dia = 6
                boldAndUnderlineButtom(btnSex)
            }
            if dia==7 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("sab")){
                dia = 7
                boldAndUnderlineButtom(btnSab)
            }
            if dia==1 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("dom")){
                dia = 1
                boldAndUnderlineButtom(btnDom)
            }
            let dict = json["turma"].dictionaryValue
            let list = dict["rows"]!.arrayValue
            for item in list{
                if (dia==1 && item["domf"].stringValue>"00:00") {
                    turmaData.addTurma(Turma(item["turma"].stringValue, item["professor"].stringValue, item["sala"].stringValue, item["atividade"].stringValue, item["domi"].stringValue, item["domf"].stringValue, item["matriculado"].boolValue))
                }
                if (dia==2 && item["segf"].stringValue>"00:00") {
                    turmaData.addTurma(Turma(item["turma"].stringValue, item["professor"].stringValue, item["sala"].stringValue, item["atividade"].stringValue, item["segi"].stringValue, item["segf"].stringValue, item["matriculado"].boolValue))
                }
                if (dia==3 && item["terf"].stringValue>"00:00") {
                    turmaData.addTurma(Turma(item["turma"].stringValue, item["professor"].stringValue, item["sala"].stringValue, item["atividade"].stringValue, item["teri"].stringValue, item["terf"].stringValue, item["matriculado"].boolValue))
                }
                if (dia==4 && item["quaf"].stringValue>"00:00") {
                    turmaData.addTurma(Turma(item["turma"].stringValue, item["professor"].stringValue, item["sala"].stringValue, item["atividade"].stringValue, item["quai"].stringValue, item["quaf"].stringValue, item["matriculado"].boolValue))
                }
                if (dia==5 && item["quif"].stringValue>"00:00") {
                    turmaData.addTurma(Turma(item["turma"].stringValue, item["professor"].stringValue, item["sala"].stringValue, item["atividade"].stringValue, item["quii"].stringValue, item["quif"].stringValue, item["matriculado"].boolValue))
                }
                if (dia==6 && item["sexf"].stringValue>"00:00") {
                    turmaData.addTurma(Turma(item["turma"].stringValue, item["professor"].stringValue, item["sala"].stringValue, item["atividade"].stringValue, item["sexi"].stringValue, item["sexf"].stringValue, item["matriculado"].boolValue))
                }
                if (dia==7 && item["sabf"].stringValue>"00:00") {
                    turmaData.addTurma(Turma(item["turma"].stringValue, item["professor"].stringValue, item["sala"].stringValue, item["atividade"].stringValue, item["sabi"].stringValue, item["sabf"].stringValue, item["matriculado"].boolValue))
                }
            }
            list1.reloadData()
            if self.firstTime==false && self.turmaData.turma.count<1{
                _ = warning(view: self, title: "Aviso", message: "Não há turmas para o dia selecionado", buttons: 1)
            }
        }
    }
        
}
