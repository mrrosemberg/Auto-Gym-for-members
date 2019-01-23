//
//  TurmaDetailController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 23/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class TurmaDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var list1: UITableView!
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return turmaDetail.elemento.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return turmaDetail.elemento[section].linhas.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return turmaDetail.elemento[section].section
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        // TODO cell como especificar a seção.
        cell.textLabel?.text = turmaDetail.elemento[indexPath.section].linhas[indexPath.row].text
        cell.textLabel?.textColor = turmaDetail.elemento[indexPath.section].linhas[indexPath.row].color
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        list1.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
