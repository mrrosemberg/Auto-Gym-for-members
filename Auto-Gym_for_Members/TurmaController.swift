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
        //self.turmaData.clear()
        self.loadTurmas(0)
        //stackVC?.append(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        list1.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
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
        let job = httpJob()
        let aluno = config["user"]!
        let senha = config["password"]!
        let agora = currentDateTime()
        let authStr = authenticate(usr: aluno, pwd: senha, time: agora)
        job.setServer(server)
        job.setPath("/vfp/APPAluno.avfp")
        job.setParameters(["objeto":"webTurma","aluno":aluno,"timestamp":agora,"sha-256":authStr, "dia":String(dia)])
        let resp = job.execute()
        turmaData.clear()
        if resp.isEmpty{
            _ = warning(view: self, title: "Erro", message: "Servidor não respondeu", buttons: 1)
            return
        }else{
            if job.getContentType().uppercased().contains("JSON"){
                //var jsonOk = 0
                if let json = try? JSON(data: resp.data(using: .utf8)!){
                    //print(resp)
                    turmaData.dayOfWeek = json["dayofweek"].stringValue
                    if dia==2 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("seg")){
                        allRegular()
                        boldAndUnderlineButtom(btnSeg)
                    }
                    if dia==3 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("ter")){
                        allRegular()
                        boldAndUnderlineButtom(btnTer)
                    }
                    if dia==4 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("qua")){
                        allRegular()
                        boldAndUnderlineButtom(btnQua)
                    }
                    if dia==5 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("qui")){
                        allRegular()
                        boldAndUnderlineButtom(btnQui)
                    }
                    if dia==6 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("sex")){
                        allRegular()
                        boldAndUnderlineButtom(btnSex)
                    }
                    if dia==7 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("sab")){
                        allRegular()
                        boldAndUnderlineButtom(btnSab)
                    }
                    if dia==1 || (dia==0 && turmaData.dayOfWeek.lowercased().contains("dom")){
                        allRegular()
                        boldAndUnderlineButtom(btnDom)
                    }
                    let dict = json["turma"].dictionaryValue
                    let list = dict["rows"]!.arrayValue
                    for item in list{
                        parcela.addParc(item["data"].stringValue, item["valor"].stringValue)
                        turmaData.addTurma(Turma(item["turma"].stringValue, item["professor"].stringValue, item["sala"].stringValue, item["atividade"].stringValue, item["inicio"].stringValue, item["fim"].stringValue, item["matriculado"].boolValue))
                    }
                    list1.reloadData()
                }else{
                    _ = warning(view: self, title: "Erro", message: "JSON de turmas coletivas inválido", buttons: 1)
                    return
                }
            }else{
                _ = warning(view: self, title: "Erro", message: resp, buttons: 1)
            }
        }
        return
    }
        
}
