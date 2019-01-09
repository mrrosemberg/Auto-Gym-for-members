//
//  MainController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 17/12/18.
//  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CryptoSwift

public var server=""
public var config=["server1":"", "server2":"", "logo":"", "icon":"", "user":"", "password":"", "academia":"", "cnpj":""]
let myParam = Param() //Coleção de parâmetros
let myAluno = Aluno() //Dados do Aluno
let parcela = Parcela() // parcelas do último pagamento


//Type strucAluno (Nome As String, CPF As String, Nascimento As String, foto As String, proxvenc As String, plano As String, email As String, idade As Int, Status As Int, tolerancia As Int, atraso As Int, datainad As String, sexo As Int)
//Type strucParam (accessAero As Boolean, accessErgo As Boolean, accessFin As Boolean, accessMusc As Boolean, accessTurma As Boolean, accessAval As Boolean, status As Int, validAero As Boolean, validAval As Boolean, validSerie As Boolean, validTurma As Boolean)


class MainController: UIViewController {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConnect: UILabel!
    @IBOutlet weak var btnGo: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let file = File(fileName: "config", fileExt: "dat")
        if file.exists(){
            config = file.read()
            if config["academia"]!.isEmpty==false{
               self.lbTitle.text = config["academia"]!
            }
            if config["logo"]!.isEmpty==false{
                self.imgLogo.image = base64ImgFromString(config["logo"]!)
            }
            if config["server1"]!.isEmpty{
                btnGo.isHidden = true
            }else{
                btnGo.isHidden = false
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func trataResp(_ resposta:String, _ contentType:String){
        lbConnect.isHidden = true
        if contentType.uppercased().contains("JSON"){
            //_ = warning(view: self, title: "Aviso", message: "Autenticação Ok", buttons:1)
            var jsonOk = 0
            if let json = try? JSON(data: resposta.data(using: .utf8)!){
                jsonOk += 1
                if json["accessaero"].boolValue{
                    myParam.accessAero = json["accessaero"].boolValue
                    jsonOk += 1 //1
                }
                if json["accessergo"].boolValue{
                    myParam.accessAero = json["accessergo"].boolValue
                    jsonOk += 1 //2
                }
                if json["accessfin"].boolValue{
                    myParam.accessAero = json["accessfin"].boolValue
                    jsonOk += 1 //3
                }
                if json["accessmusc"].boolValue{
                    myParam.accessAero = json["accessmusc"].boolValue
                    jsonOk += 1 //4
                }
                if json["accessaval"].boolValue{
                    myParam.accessAero = json["accessaval"].boolValue
                    jsonOk += 1 //5
                }
                if json["validaero"].boolValue{
                    myParam.accessAero = json["validaero"].boolValue
                    jsonOk += 1 //6
                }
                if json["validaval"].boolValue{
                    myParam.accessAero = json["validaval"].boolValue
                    jsonOk += 1 //7
                }
                if json["validturma"].boolValue{
                    myParam.accessAero = json["validturma"].boolValue
                    jsonOk += 1 //8
                }
                if json["status"].intValue > -1{
                    myParam.status = json["status"].intValue
                    myAluno.Status = myParam.status
                    jsonOk += 1 //9
                }
                if json["cpf"].stringValue.isEmpty==false{
                    myAluno.CPF = json["cpf"].stringValue
                    jsonOk += 1 //10
                }
                if json["email"].stringValue.isEmpty==false{
                    myAluno.email = json["email"].stringValue
                    jsonOk += 1 //11
                }
                if json["datainad"].stringValue.isEmpty==false{
                    myAluno.datainad = json["datainad"].stringValue
                    jsonOk += 1 //12
                }
                if json["foto"].stringValue.isEmpty==false{
                    myAluno.foto = json["foto"].stringValue
                    jsonOk += 1 //13
                }
                if json["nome"].stringValue.isEmpty==false{
                    myAluno.Nome = json["nome"].stringValue
                    jsonOk += 1 //14
                }
                if json["idade"].intValue > -1{
                    myAluno.idade = json["idade"].intValue
                    jsonOk += 1 //15
                }
                if json["nascimento"].stringValue.isEmpty==false{
                    myAluno.Nascimento = json["nascimento"].stringValue
                    jsonOk += 1 //16
                }
                if json["plano"].stringValue.isEmpty==false{
                    myAluno.plano = json["plano"].stringValue
                    jsonOk += 1 //17
                }
                if json["proxvenc"].stringValue.isEmpty==false{
                    myAluno.proxvenc = json["proxvenc"].stringValue
                    jsonOk += 1 //18
                }
                if json["tolerancia"].intValue > -1{
                    myAluno.tolerancia = json["tolerancia"].intValue
                    jsonOk += 1 //19
                }
                if json["sexo"].intValue > -1{
                    myAluno.sexo = json["sexo"].intValue
                    jsonOk += 1 //20
                }
                parcela.clear()
                let dict = json["parc"].dictionaryValue
                if dict.count>0{
                    let list = dict["rows"]!.arrayValue
                    print(list.count)
                    for item in list{
                        parcela.addParc(item["data"].stringValue, item["valor"].stringValue)
                    }
                    for eachParc in parcela.parcela{
                        print("Data: "+eachParc.data + " , Valor: "+eachParc.valor)
                    }
                }
               
                if jsonOk<20{
                    _=warning(view:self, title:"Erro", message:"JSON inválido nível: " + String(jsonOk), buttons:1)
                }else{
                    _ = warning(view: self, title: "Aviso", message: "Autenticação Ok, JSON Ok", buttons:1)
                }
            }else{
                _ = warning(view: self, title: "Erro", message: "JSON de aluno e parâmetro inválido", buttons:1)
            }// JSON Ok
        }
        else{
            _ = warning(view: self, title: "Erro", message: resposta, buttons:1)
        }// contentType
    }// trataResp
    
    @IBAction func btnGoClick(_ sender: Any) {
        let job = httpJob()
        server = config["server1"]!
        //server = "192.168.0.5:9000"
        let aluno = config["user"]!
        let senha = config["password"]!
        let agora = currentDateTime()
        let authStr = authenticate(usr: aluno, pwd: senha, time: agora)
        //agora = agora.replacingOccurrences(of: " ", with: "%20")
        job.setServer(server)
        job.setPath("/vfp/APPAluno.avfp")
        job.setParameters(["objeto":"webAuthAluno","aluno":aluno,"timestamp":agora,"sha-256":authStr])
        lbConnect.text = "Conectando Servidor1..."
        lbConnect.isHidden = false
        var resp = job.execute()
        if resp.isEmpty{
           lbConnect.text = "Conectando Servidor2..."
            server = config["server2"]!
            job.setServer(server)
            resp = job.execute()
            if resp.isEmpty{
                _ = warning(view: self, title: "Erro", message: "Sem conexão com o servidor", buttons:1)
                lbConnect.isHidden = true
                return
            }else{
               self.trataResp(resp, job.getContentType())
            }
        }else{
            self.trataResp(resp, job.getContentType())
        }
    }// action Go
}
