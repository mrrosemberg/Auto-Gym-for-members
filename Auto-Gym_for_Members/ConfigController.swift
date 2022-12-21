//
//  ConfigController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 14/12/18.
//  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConfigController: UIViewController {
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let academia = config["academia"]!
        if academia.isEmpty {
           lbAcademia.isHidden = true
           lbAddress1.isHidden = true
           lbAddress2.isHidden = true
        }else{
            self.txtCnpj.text = config["cnpj"]!
            self.lbAddress1.text = config["server1"]!
            self.lbAddress2.text = config["server2"]!
            self.lbAcademia.text = config["academia"]!
            self.txtMatricula.text = config["user"]!
            self.txtSenha.text = config["password"]!
            lbAcademia.isHidden = false
            lbAddress1.isHidden = false
            lbAddress2.isHidden = false
        }
    }
    
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func trataResp(){
        if self.contentType.contains("text"){
            _=warning(view:self, title:"Erro", message:self.webData, buttons: 1)
            return
        }
        if self.contentType.contains("json")==false{
            _=warning(view:self, title:"Erro", message:"Retorno inválido do servidor", buttons: 1)
            return
        }
        lbAcademia.isHidden = true
        lbAddress1.isHidden = true
        lbAddress2.isHidden = true
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
            }else{
                config["cnpj"]=self.txtCnpj.text!
                config["server1"]=self.lbAddress1.text!
                config["server2"]=self.lbAddress2.text!
                config["academia"]=self.lbAcademia.text!
                config["icone"]=json["icone"].stringValue
                config["logo"]=json["logo"].stringValue
                server = config["server1"]!
                lbAcademia.isHidden = false
                lbAddress1.isHidden = false
                lbAddress2.isHidden = false
            }
            
        }// endif Try
        
    } //trataresp
    

    @IBAction func validarClick(_ sender: Any) {
        let job = httpJob()
        job.setServer("sysnetweb.com.br:4080")
        job.setPath("/vfp/validacnpj.avfp")
        job.setParameters(["cnpj":txtCnpj.text!])
        self.webData = job.execute()
        if self.webData.isEmpty{
            _ = warning(view: self, title: "Erro", message: job.getLastError(), buttons: 1)
            return
        }else{
            self.contentType = job.getContentType()
            self.trataResp()
        }
     }//validarClick
   
    @IBAction func actionOk(_ sender: Any) {
        if txtMatricula.text==nil || txtMatricula.text!.isEmpty {
            _=warning(view:self, title:"Erro", message:"Matrícula Inválida", buttons:1)
            return
        }//endif validação txtMatricula
        if txtSenha.text==nil || txtSenha.text!.isEmpty {
            _=warning(view:self, title:"Erro", message:"Senha Inválida", buttons:1)
            return
        }//endif validação txtSenha
        if lbAcademia.isHidden {
            return
        }
        let substr = ("000000"+txtMatricula.text!).suffix(6)
        config["user"] = String(substr)
        config["password"]=txtSenha.text!
        txtMatricula.text = config["user"]
        let file = File(fileName:"config", fileExt:"dat")
        file.write(writeDict: config)
        if file.getLastError().isEmpty==false {
            _=warning(view:self, title:"Erro", message:"Erro gravando arquivo config.dat "+file.getLastError(), buttons:1)
            return
        }
        server = config["server1"]!
        self.dismiss(animated:true, completion:
            {
        self.presentingViewController?.viewDidAppear(false)
        }
        )
    }// actionOk
    
    // apaga o arquivo de configurações para debug
    @IBAction func btnLimpa(_ sender: Any) {
        let file = File(fileName:"config", fileExt:"dat")
        if !file.delete(){
            _=warning(view: self, title: "Erro", message: "Incapaz de deletar "+file.fileName+"."+file.fileExt+". "+file.getLastError(), buttons: 1)
        }
    }//action limpa
}//ConfigController
