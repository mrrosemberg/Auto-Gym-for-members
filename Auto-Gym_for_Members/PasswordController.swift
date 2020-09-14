//
//  PasswordController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 24/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import UIKit
import SwiftyJSON

class PasswordController: UIViewController {
    
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var senha1: UITextField!
    @IBOutlet weak var senha2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func processaSenha()->Bool{
        if senha1.text!.count<8{
            _ = warning(view: self, title: "Erro", message: "Senha tem que ter 8 caracteres ou mais", buttons: 1)
            return false
        }
        if (senha1.text! == senha2.text!) == false{
            _ = warning(view: self, title: "Erro", message: "Senhas digitadas não são iguais", buttons: 1)
            return false
        }
        let job = httpJob()
        let aluno = config["user"]!
        let senha = config["password"]!
        let agora = currentDateTime()
        let authStr = authenticate(usr: aluno, pwd: senha, time: agora)
        let novaSenha = makeNewPassword(senha1.text!, aluno, senha, agora)
        job.setServer(server)
        job.setPath("/asp/aspgym.aspx")
        job.setParameters(["objeto":"aspsenha","aluno":aluno,"timestamp":agora,"sha-256":authStr, "senha":novaSenha])
        let resp = job.execute()
        if resp.isEmpty{
            _ = warning(view: self, title: "Erro", message: "Servidor não respondeu", buttons: 1)
            return false
        }else{
            if job.getContentType().uppercased().contains("JSON"){
                //var jsonOk = 0
                if let json = try? JSON(data: resp.data(using: .utf8)!){
                    if json["success"].boolValue == false{
                        //print("Chave: "+json["chave"].stringValue)
                        //print("Senha decifrada no servidor: "+json["senhaplain"].stringValue)
                        _ = warning(view: self, title: "Erro", message: "Senha não foi alterada", buttons: 1)
                        return false
                    }
                }else{
                    _ = warning(view: self, title: "Erro", message: "JSON de troca de senha inválido", buttons: 1)
                    return false
                }
            }else{
                _ = warning(view: self, title: "Erro", message: resp, buttons: 1)
                return false
            }
        }
        // _ = warning(view: self, title: "Aviso", message: "Senha alterada com sucesso", buttons: 1)
        return true
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOkClick(_ sender: Any) {
        if processaSenha(){
            config["password"]=senha1.text!
            let file = File(fileName:"config", fileExt:"dat")
            file.write(writeDict: config)
            if file.getLastError().isEmpty==false {
                _=warning(view:self, title:"Erro", message:"Erro gravando arquivo config.dat "+file.getLastError(), buttons:1)
                return
            }
           performSegue(withIdentifier: "PasswordOkController", sender: nil)
        }
    }
}
