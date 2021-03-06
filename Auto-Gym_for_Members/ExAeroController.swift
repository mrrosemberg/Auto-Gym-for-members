//
//  ExAeroController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 23/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit

fileprivate class Det{
    var title:String
    var content:String
    init(_ title:String, _ content:String){
        self.title = title
        self.content = content
    }
}

class ExAeroController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var list1: UITableView!
    
    fileprivate var exDet = [Det("","")]
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exDet.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Detalhes do Exercício"
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        let pointer = indexPath.row
        let line1 = exDet[pointer].title
        let line2 = exDet[pointer].content
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
        exDet.removeAll()
        var ex = ExAero()
        for item in aero.exercicios{
            if item.seq==aero.header.selectedSeq{
                ex = item
                break
            }
        }
        exDet.append(Det("Exercício:", ex.exbio))
        exDet.append(Det("Zona Alvo:", aero.header.zonaalvo))
        exDet.append(Det("Frequencia Cardíaca:", ex.fc))
        exDet.append(Det("Tempo de Execução:", ex.tempo))
        exDet.append(Det("Escala de Borg:", ex.borg))
        exDet.append(Det("Regulagem:", ex.regulagem))
        
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
