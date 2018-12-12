//
//  ViewController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 11/12/18.
//  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var lbAcademia: UILabel!
    @IBOutlet weak var lbAddress1: UILabel!
    @IBOutlet weak var lbAddress2: UILabel!
    @IBOutlet weak var txtCnpj: JMMaskTextField!
    @IBOutlet weak var txtMatricula: JMMaskTextField!
    @IBOutlet weak var txtSenha: JMMaskTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
 
    
     @IBAction func validarClick(_ sender: Any) {
        if txtCnpj.text==nil || txtCnpj.text!.isEmpty || txtCnpj.text!.count != 18 || txtCnpj.text!.contains(" "){
            _=warning(view:self, title:"Erro", message:"CNPJ Inválido", buttons:1)
            return
                
        }
        let urlString = "http://sysnetweb.com.br:4080/vfp/validacnpj.avfp"
        Alamofire.request(urlString, method: .get, parameters: ["cnpj":txtCnpj.text!]).responseJSON{
         response in
            print(response.response!.accessibilityContainerType)
            if let err = response.error {
                let msg = "Erro de comunicação com o servidor:\n \(err)"
                _=warning(view:self, title:"Erro", message:msg, buttons:1)  // response error
                return
            }
            if response.result.value==nil {
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    _=warning(view:self, title:"Erro", message:utf8Text, buttons:1)  // response error
                    return
                }else {
                    _=warning(view:self, title:"Erro", message:"O Aplicativo comportou-se de forma inesperada", buttons:1)  // response error
                    return
                }
            }
            print(response.result.value!)
            
        }// Alamofire
      }//validarClick
    
    
}//View Controller
    


