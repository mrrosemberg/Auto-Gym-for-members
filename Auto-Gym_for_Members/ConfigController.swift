//
//  ConfigController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 14/12/18.
//  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ConfigController: UIViewController {

    @IBOutlet weak var txtSenha: JMMaskTextField!
    @IBOutlet weak var txtMatricula: JMMaskTextField!
    @IBOutlet weak var lbAddress2: UILabel!
    @IBOutlet weak var lbAddress1: UILabel!
    @IBOutlet weak var lbAcademia: UILabel!
    @IBOutlet weak var txtCnpj: JMMaskTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func validarClick(_ sender: Any) {
        if txtCnpj.text==nil || txtCnpj.text!.isEmpty || txtCnpj.text!.count != 18 || txtCnpj.text!.contains(" "){
            _=warning(view:self, title:"Erro", message:"CNPJ Inválido", buttons:1)
            return
        }//endif validação txtCnpj
        
    }//validarClick
   
}
