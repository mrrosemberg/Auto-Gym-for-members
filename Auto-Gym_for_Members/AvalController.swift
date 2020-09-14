//
//  AvalController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 25/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import UIKit
import SwiftyJSON

fileprivate class Det{
    var titleText:String
    var leftText:String
    var centerText:String
    var rightText:String
    init(_ titleText:String,_ leftText:String,_ centerText:String,_ rightText:String){
        self.titleText = titleText
        self.leftText = leftText
        self.centerText = centerText
        self.rightText = rightText
    }
}

fileprivate class Secao{
    var section : String
    var sectionData : [Det]
    
    init(){
        self.section = ""
        self.sectionData = [Det("","","","")]
    }
    
    init(_ section: String){
        self.section = section
        self.sectionData = [Det("","","","")]
    }
    
    init(_ section: String,_ firstTitle: String,_ firstLeftLabel: String,_ firstCenterLabel: String,_ firstRightLabel: String){
        self.section = section
        self.sectionData = [Det(firstTitle,firstLeftLabel,firstCenterLabel,firstRightLabel)]
    }
}

fileprivate class Lista{
    var elemento : [Secao]
    
    init(){
        self.elemento = [Secao()]
    }
    
    init(_ section: String){
        self.elemento = [Secao(section)]
    }
    
    init(_ section: String,_ firstTitle: String,_ firstLeftLabel: String,_ firstCenterLabel: String,_ firstRightLabel: String){
        self.elemento = [Secao(section, firstTitle, firstLeftLabel, firstCenterLabel, firstRightLabel)]
    }
    
    fileprivate func appendSection(_ section: String){
        self.elemento.append(Secao(section))
        self.elemento[self.elemento.count-1].sectionData.removeAll()
    }
    
    fileprivate func appendRowInSection(_ section: Int, _ title: String,_ leftLabel: String,_ centerLabel: String,_ rightLabel: String)
    {
        self.elemento[section].sectionData.append(Det(title, leftLabel, centerLabel, rightLabel))
    }
}

class AvalController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var list1: UITableView!
    
    fileprivate var aval = Lista()
    var qtdAval = 0
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return aval.elemento.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aval.elemento[section].sectionData.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return aval.elemento[section].section
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AvalCell", owner: self, options: nil)?.first as! AvalCell
        let pointer = indexPath.row
        let section = indexPath.section
        cell.backgroundColor = UIColor.clear
        cell.title.text = aval.elemento[section].sectionData[pointer].titleText
        cell.title.textColor = UIColor.white
        cell.title.font = UIFont.boldSystemFont(ofSize: 17)
        cell.leftLabel.text = aval.elemento[section].sectionData[pointer].leftText
        cell.leftLabel.textColor = UIColor.white
        cell.centerLabel.text = aval.elemento[section].sectionData[pointer].centerText
        cell.centerLabel.textColor = UIColor.white
        cell.rightLabel.text = aval.elemento[section].sectionData[pointer].rightText
        cell.rightLabel.textColor = UIColor.white
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        aval.elemento.removeAll()
        if let json = try? JSON(data: rawAval.data(using: .utf8)!){
            //print(rawAval)
            qtdAval = json["qtdaval"].intValue
            if qtdAval==0{
                return
            }
            let dict = json["lista"].dictionaryValue
            let list = dict["rows"]!.arrayValue
            var tit = "Data"
            var lft = list[0]["data"].stringValue
            var ctr = ""
            var rgh = ""
            if qtdAval>1{
                ctr = list[1]["data"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["data"].stringValue
            }
            aval.appendSection("Perimetria")
            aval.appendRowInSection(0, tit, lft, ctr, rgh)
            aval.appendSection("Composição Corporal")
            aval.appendRowInSection(1, tit, lft, ctr, rgh)
            if myParam.accessErgo{
                aval.appendSection("Ergometria")
                aval.appendRowInSection(2, tit, lft, ctr, rgh)
            }
            tit = "Tórax"
            lft = list[0]["torax"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["torax"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["torax"].stringValue
            }
            aval.appendRowInSection(0, tit, lft, ctr, rgh)
            tit = "Braço Direito"
            lft = list[0]["braco_d"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["braco_d"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["braco_d"].stringValue
            }
            aval.appendRowInSection(0, tit, lft, ctr, rgh)
            tit = "Braço Esquerdo"
            lft = list[0]["braco_e"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["braco_e"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["braco_e"].stringValue
            }
            aval.appendRowInSection(0, tit, lft, ctr, rgh)
            if myAluno.sexo==1{
                tit = "Antebraço Direito"
                lft = list[0]["antbraco_d"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["antbraco_d"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["antbraco_d"].stringValue
                }
                aval.appendRowInSection(0, tit, lft, ctr, rgh)
                tit = "Antebraço Esquerdo"
                lft = list[0]["antbraco_e"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["antbraco_e"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["antbraco_e"].stringValue
                }
                aval.appendRowInSection(0, tit, lft, ctr, rgh)
            }
            tit = "Abdome"
            lft = list[0]["abdome"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["abdome"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["abdome"].stringValue
            }
            aval.appendRowInSection(0, tit, lft, ctr, rgh)
            if myAluno.sexo==2{
                tit = "Quadril"
                lft = list[0]["quadril"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["quadril"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["quadril"].stringValue
                }
                aval.appendRowInSection(0, tit, lft, ctr, rgh)
            }
            tit = "Coxa Superior Direita"
            lft = list[0]["coxasup_d"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["coxasup_d"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["coxasup_d"].stringValue
            }
            aval.appendRowInSection(0, tit, lft, ctr, rgh)
            tit = "Coxa Superior Esquerda"
            lft = list[0]["coxasup_e"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["coxasup_e"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["coxasup_e"].stringValue
            }
            tit = "Coxa Inferior Direita"
            lft = list[0]["coxainf_d"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["coxainf_d"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["coxainf_d"].stringValue
            }
            aval.appendRowInSection(0, tit, lft, ctr, rgh)
            tit = "Coxa Inferior Esquerda"
            lft = list[0]["coxainf_e"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["coxainf_e"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["coxainf_e"].stringValue
            }
            tit = "Perna Direita"
            lft = list[0]["perna_d"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["perna_d"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["perna_d"].stringValue
            }
            aval.appendRowInSection(0, tit, lft, ctr, rgh)
            tit = "Perna Esquerda"
            lft = list[0]["perna_e"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["perna_e"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["perna_e"].stringValue
            }
            aval.appendRowInSection(0, tit, lft, ctr, rgh)
            tit = "Peso (Kg)"
            lft = String(list[0]["peso"].intValue)
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = String(list[1]["peso"].intValue)
            }
            if qtdAval>2{
                rgh = String(list[2]["peso"].intValue)
            }
            aval.appendRowInSection(1, tit, lft, ctr, rgh)
            tit = "Estatura (m)"
            lft = list[0]["estatura"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["estatura"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["estatura"].stringValue
            }
            aval.appendRowInSection(1, tit, lft, ctr, rgh)
            tit = "% de Gordura"
            lft = list[0]["gordura"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["gordura"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["gordura"].stringValue
            }
            aval.appendRowInSection(1, tit, lft, ctr, rgh)
            tit = "Classificação"
            lft = list[0]["class_grd"].stringValue
            ctr = ""
            rgh = ""
            if qtdAval>1{
                ctr = list[1]["class_grd"].stringValue
            }
            if qtdAval>2{
                rgh = list[2]["class_grd"].stringValue
            }
            aval.appendRowInSection(1, tit, lft, ctr, rgh)
            if myParam.accessErgo{
                tit = "Pressão Arterial Repouso (S)"
                lft = list[0]["pars"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["pars"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["pars"].stringValue
                }
                aval.appendRowInSection(2, tit, lft, ctr, rgh)
                tit = "Pressão Arterial Repouso (D)"
                lft = list[0]["pard"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["pard"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["pard"].stringValue
                }
                aval.appendRowInSection(2, tit, lft, ctr, rgh)
                tit = "Frequência Cardíaca Repouso (BPM)"
                lft = list[0]["fcr"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["fcr"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["fcr"].stringValue
                }
                aval.appendRowInSection(2, tit, lft, ctr, rgh)
                tit = "Pressão Arterial Máxima (S)"
                lft = list[0]["pams"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["pams"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["pams"].stringValue
                }
                aval.appendRowInSection(2, tit, lft, ctr, rgh)
                tit = "Pressão Arterial Máxima (D)"
                lft = list[0]["pamd"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["pamd"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["pamd"].stringValue
                }
                aval.appendRowInSection(2, tit, lft, ctr, rgh)
                tit = "Frequência Cardíaca Máxima (BPM)"
                lft = list[0]["fcmax"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["fcmax"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["fcmax"].stringValue
                }
                aval.appendRowInSection(2, tit, lft, ctr, rgh)
                tit = "Carga (Watts)"
                lft = list[0]["carga"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["carga"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["carga"].stringValue
                }
                aval.appendRowInSection(2, tit, lft, ctr, rgh)
                tit = "VO2"
                lft = list[0]["vo2"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["vo2"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["vo2"].stringValue
                }
                aval.appendRowInSection(2, tit, lft, ctr, rgh)
                tit = "Classificação"
                lft = list[0]["class_vo2"].stringValue
                ctr = ""
                rgh = ""
                if qtdAval>1{
                    ctr = list[1]["class_vo2"].stringValue
                }
                if qtdAval>2{
                    rgh = list[2]["class_vo2"].stringValue
                }
                aval.appendRowInSection(2, tit, lft, ctr, rgh)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        list1.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
