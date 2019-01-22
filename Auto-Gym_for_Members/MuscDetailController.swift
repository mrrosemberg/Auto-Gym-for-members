//
//  MuscDetailController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 22/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit

class MuscDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var list1: UITableView!
    
    var listaMusc = [Exercicio()]
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        serie.header.selectedSeq = listaMusc[indexPath.row].seq
        performSegue(withIdentifier: "ExMuscController", sender: nil)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaMusc.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var ret = "Lista de Exercícios - "
        
        if serie.header.diaourotina == "rotina"{
            ret.append("Rotina: ")
            if serie.header.dia == 1{
                ret.append("G")
            }
            if serie.header.dia == 2{
                ret.append("A")
            }
            if serie.header.dia == 3{
                ret.append("B")
            }
            if serie.header.dia == 4{
                ret.append("C")
            }
            if serie.header.dia == 5{
                ret.append("D")
            }
            if serie.header.dia == 6{
                ret.append("E")
            }
            if serie.header.dia == 7{
                ret.append("F")
            }
        }else{
            if serie.header.dia == 1{
                ret.append("Domingo")
            }
            if serie.header.dia == 2{
                ret.append("Segunda")
            }
            if serie.header.dia == 3{
                ret.append("Terça")
            }
            if serie.header.dia == 4{
                ret.append("Quarta")
            }
            if serie.header.dia == 5{
                ret.append("Quinta")
            }
            if serie.header.dia == 6{
                ret.append("Sexta")
            }
            if serie.header.dia == 7{
                ret.append("Sábado")
            }
        }
        
        return ret
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        let pointer = indexPath.row
        var line1 = "Exercício: " + listaMusc[pointer].exercicio
        if listaMusc[pointer].series.isEmpty==false{
            line1.append(". Séries: " + listaMusc[pointer].series)
        }
        var line2 = ""
        if listaMusc[pointer].carga.isEmpty==false{
            line2.append("Carga: " + listaMusc[pointer].carga)
        }
        if listaMusc[pointer].repeticoes.isEmpty==false{
            if line2.isEmpty==false{
                line2.append(", ")
            }
            line2.append("Rep.: " + listaMusc[pointer].repeticoes)
        }
        if listaMusc[pointer].regulagem.isEmpty==false{
            if line2.isEmpty==false{
                line2.append(", ")
            }
            line2.append("Reg.: " + listaMusc[pointer].regulagem)
        }
        cell.textLabel?.text = line1
        cell.detailTextLabel?.text = line2
        cell.detailTextLabel?.font = UIFont.init(name: "System", size: 15)
        cell.textLabel?.font = UIFont.init(name: "System", size: 15)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaMusc.removeAll()
        for item in serie.exercicios{
            if item.domingo && serie.header.dia==1{
                listaMusc.append(item)
            }
            if item.segunda && serie.header.dia==2{
                listaMusc.append(item)
            }
            if item.terca && serie.header.dia==3{
                listaMusc.append(item)
            }
            if item.quarta && serie.header.dia==4{
                listaMusc.append(item)
            }
            if item.quinta && serie.header.dia==5{
                listaMusc.append(item)
            }
            if item.sexta && serie.header.dia==6{
                listaMusc.append(item)
            }
            if item.sabado && serie.header.dia==7{
                listaMusc.append(item)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        list1.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
