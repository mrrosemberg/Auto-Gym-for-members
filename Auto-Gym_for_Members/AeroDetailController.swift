//
//  AeroDetailController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 23/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit

class AeroDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var list1: UITableView!
    
    var listaAero = [ExAero()]
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        aero.header.selectedSeq = listaAero[indexPath.row].seq
        performSegue(withIdentifier: "ExAeroController", sender: nil)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaAero.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var ret = "Exercícios Aeróbios - "
        
        if aero.header.diaourotina == "rotina"{
            ret.append("Rotina: ")
            if aero.header.dia == 1{
                ret.append("G")
            }
            if aero.header.dia == 2{
                ret.append("A")
            }
            if aero.header.dia == 3{
                ret.append("B")
            }
            if aero.header.dia == 4{
                ret.append("C")
            }
            if aero.header.dia == 5{
                ret.append("D")
            }
            if aero.header.dia == 6{
                ret.append("E")
            }
            if aero.header.dia == 7{
                ret.append("F")
            }
        }else{
            if aero.header.dia == 1{
                ret.append("Domingo")
            }
            if aero.header.dia == 2{
                ret.append("Segunda")
            }
            if aero.header.dia == 3{
                ret.append("Terça")
            }
            if aero.header.dia == 4{
                ret.append("Quarta")
            }
            if aero.header.dia == 5{
                ret.append("Quinta")
            }
            if aero.header.dia == 6{
                ret.append("Sexta")
            }
            if aero.header.dia == 7{
                ret.append("Sábado")
            }
        }
        
        return ret
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        let pointer = indexPath.row
        var line1 = "Exercício: " + listaAero[pointer].exbio
        if listaAero[pointer].tempo.isEmpty==false{
            line1.append(". Tempo: " + listaAero[pointer].tempo)
        }
        var line2 = ""
        if listaAero[pointer].fc.isEmpty==false{
            line2.append("FC.: " + listaAero[pointer].fc)
        }
        if listaAero[pointer].borg.isEmpty==false{
            if line2.isEmpty==false{
                line2.append(", ")
            }
            line2.append("Esc. Borg: " + listaAero[pointer].borg)
        }
        if listaAero[pointer].regulagem.isEmpty==false{
            if line2.isEmpty==false{
                line2.append(", ")
            }
            line2.append("Reg.: " + listaAero[pointer].regulagem)
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
        listaAero.removeAll()
        for item in aero.exercicios{
            if item.domingo && aero.header.dia==1{
                listaAero.append(item)
            }
            if item.segunda && aero.header.dia==2{
                listaAero.append(item)
            }
            if item.terca && aero.header.dia==3{
                listaAero.append(item)
            }
            if item.quarta && aero.header.dia==4{
                listaAero.append(item)
            }
            if item.quinta && aero.header.dia==5{
                listaAero.append(item)
            }
            if item.sexta && aero.header.dia==6{
                listaAero.append(item)
            }
            if item.sabado && aero.header.dia==7{
                listaAero.append(item)
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
