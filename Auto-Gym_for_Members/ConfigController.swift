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
    var alamoFireManager : SessionManager?
    var contentType = "text/plain"
    var webData = ""
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
        
    func trataResp(){
        //print(self.webData)
        print(self.contentType)
        if self.contentType.contains("text"){
            _=warning(view:self, title:"Erro", message:self.webData, buttons: 1)
            return
        }
        if self.contentType.contains("json")==false{
            _=warning(view:self, title:"Erro", message:"Retorno inválido do servidor", buttons: 1)
            return
        }
        var jsonOk = 0
        if let json = try? JSON(data: self.webData.data(using: .utf8)!){
            jsonOk += 1
            if json["server"].stringValue.isEmpty==false{
                self.lbAddress1.text = json["server"].stringValue
                jsonOk += 1
            }
            if json["server2"].stringValue.isEmpty==false{
                self.lbAddress2.text = json["server2"].stringValue
                jsonOk += 1
            }
            if json["academia"].stringValue.isEmpty==false{
                self.lbAcademia.text = json["academia"].stringValue
                jsonOk += 1
            }
            if json["icone"].stringValue.isEmpty==false{
                jsonOk += 1
            }
            if json["logo"].stringValue.isEmpty==false{
                jsonOk += 1
            }
            if jsonOk<6{
                _=warning(view:self, title:"Erro", message:"JSON inválido nível: " + String(jsonOk), buttons:1)
            }
            
        }// endif Try
        
    } //trataresp
    

    @IBAction func validarClick(_ sender: Any) {
        if txtCnpj.text==nil || txtCnpj.text!.isEmpty || txtCnpj.text!.count != 18 || txtCnpj.text!.contains(" "){
            _=warning(view:self, title:"Erro", message:"CNPJ Inválido", buttons:1)
            return
        }//endif validação txtCnpj
        let param = ["cnpj":txtCnpj.text!]
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        
        alamoFireManager!.request("http://sysnetweb.com.br:4080/vfp/validacnpj.avfp", method:.get, parameters: param)
            .validate(statusCode: 200..<300)
            .responseString {
                response in
                if response.result.isFailure {
                    if let err = response.error?.localizedDescription {
                        _=warning(view: self, title:"Erro", message: "Sem conexão com o servidor"+err, buttons: 1)
                        return
                    }
                    _=warning(view: self, title:"Erro", message: "Sem conexão com o servidor", buttons: 1)
                        return
                } //endif result.isFailure
                if let data = response.data, let dados = String(data: data, encoding: .utf8){
                    self.webData = dados
                    if let cType = response.response?.allHeaderFields["Content-Type"] as? String {
                        self.contentType = cType.lowercased()
                    }
                }else{
                    _=warning(view: self, title:"Erro", message: "Sem resposta do servidor", buttons: 1)
                    return
                }//endif response.data
                self.trataResp()
        }//alamofireManager
     }//validarClick
   
    @IBAction func actionOk(_ sender: Any) {
    }
}//ConfigController
