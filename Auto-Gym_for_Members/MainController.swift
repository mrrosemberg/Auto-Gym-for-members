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
           _ = warning(view: self, title: "Aviso", message: "Autenticação Ok", buttons:1)
        }else{
           _ = warning(view: self, title: "Aviso", message: resposta, buttons:1)
        }
    }
    
    @IBAction func btnGoClick(_ sender: Any) {
        let job = httpJob()
        server = config["server1"]!
        //server = "192.168.0.5:9000"
        let aluno = config["user"]!
        let senha = config["password"]!
        var agora = currentDateTime()
        let authStr = authenticate(usr: aluno, pwd: senha, time: agora)
        agora = agora.replacingOccurrences(of: " ", with: "%20")
        //job.Download2("http://"&server&"",            Array As String("objeto", "webAuthAluno","aluno",user,"timestamp",agora,"sha-256",authStr))        job.setServer(server)
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
