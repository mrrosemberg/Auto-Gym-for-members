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
    var alamoFireManager : SessionManager? // this line
    @IBOutlet weak var lbAcademia: UILabel!
    @IBOutlet weak var lbAddress1: UILabel!
    @IBOutlet weak var lbAddress2: UILabel!
    @IBOutlet weak var txtCnpj: JMMaskTextField!
    @IBOutlet weak var txtMatricula: JMMaskTextField!
    @IBOutlet weak var txtSenha: JMMaskTextField!
    struct alamoret {
           var result = ""
           var success = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
 
func alamoFire()->alamoret {
        var ret = alamoret()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        ret.success = false
        ret.result = ""
        let urlString = "http://sysnetweb.com.br:4080/vfp/validacnpj.avfp"
        Alamofire.request(urlString, method: .get, parameters: ["cnpj":txtCnpj.text!]).responseString{
            response in
                if response.result.isFailure {
                   if let err = response.error?.localizedDescription {
                      let msg = "Erro de comunicação com o servidor:\n \(err)"
                      _=warning(view:self, title:"Erro", message:msg, buttons:1)  // response error
                   }
                  }else
                  {
                      if let data = response.data, let dados = String(data: data, encoding: .utf8){
                          if let cType = response.response?.allHeaderFields["Content-Type"] as? String {
                              if cType.lowercased().range(of:"text/plain") != nil {
                                 _=warning(view:self, title:"Erro", message:dados, buttons:1)
                              }else
                              {
                                ret.result = dados
                                ret.success = true
print("passou pelo ret.sucess=true")
print(dados.count)
                              }

                           }
                        }
                   }
     }
     return ret
   }//alamoFire

     @IBAction func validarClick(_ sender: Any) {
        if txtCnpj.text==nil || txtCnpj.text!.isEmpty || txtCnpj.text!.count != 18 || txtCnpj.text!.contains(" "){
            _=warning(view:self, title:"Erro", message:"CNPJ Inválido", buttons:1)
            return
        }
        var resposta = alamoFire()
        if resposta.success{
           var json = JSON(resposta.result)
           print(json.count)
           print(json)
        }
        print(resposta.success)
    }//validarClick
    

}//View Controller
    


