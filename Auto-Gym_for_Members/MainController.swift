//
//  MainController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 17/12/18.
//  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
//

import UIKit
import SwiftyJSON
import CryptoSwift
import GoogleMobileAds

public var server=""
//public var googleAdDisplayed = false
public var config=["server1":"", "server2":"", "logo":"", "icon":"", "user":"", "password":"", "academia":"", "cnpj":""]
let myParam = Param() //Coleção de parâmetros
let myAluno = Aluno() //Dados do Aluno
let parcela = Parcela() // parcelas do último pagamento
var turmaDetail = ListaSecao([lista("Detalhes da Turma",[linha("Turma: ")])])
var serie = Serie([Exercicio()],MyMusc())
var aero = Aero([ExAero()],MyAero())
var rawAval = ""
var rawSerie = ""
var rawAero = ""
var rawTurmas = ""
let adId = "ca-app-pub-4425679828859390/3663886726"
var qtdFalhasGoogleAd = 0
var AppIsValid = true
var jaChecouVersao = false
let AppVersion = "1.0.1" //current AppVersion

class MainController: UIViewController, GADInterstitialDelegate {
    
    var interstitial: GADInterstitial!
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConnect: UILabel!
    @IBOutlet weak var btnGo: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: adId)
        let request = GADRequest()
        interstitial.load(request)
        interstitial = createAndLoadInterstitial()
        interstitial.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print(view.frame.size.width)
        self.AppValidate()
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
        lbConnect.isHidden = true
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
        lbConnect.setCaption("Carregando Dados...")
        if contentType.uppercased().contains("JSON"){
            //_ = warning(view: self, title: "Aviso", message: "Autenticação Ok", buttons:1)
            var jsonOk = 0
            //print(resposta)
            if let json = try? JSON(data: resposta.data(using: .utf8)!){
                jsonOk += 1
                if json["accessaero"].boolValue{
                    myParam.accessAero = json["accessaero"].boolValue
                    jsonOk += 1 //2
                }
                if json["accessergo"].boolValue{
                    myParam.accessErgo = json["accessergo"].boolValue
                    jsonOk += 1 //3
                }
                if json["accessfin"].boolValue{
                    myParam.accessFin = json["accessfin"].boolValue
                    jsonOk += 1 //4
                }
                if json["accessmusc"].boolValue{
                    myParam.accessMusc = json["accessmusc"].boolValue
                    jsonOk += 1 //5
                }
                if json["accessturma"].boolValue{
                    myParam.accessTurma = json["accessturma"].boolValue
                    jsonOk += 1 //6
                }
                if json["accessaval"].boolValue{
                    myParam.accessAval = json["accessaval"].boolValue
                    jsonOk += 1 //7
                }
                if json["validaero"].boolValue{
                    myParam.validAero = json["validaero"].boolValue
                    jsonOk += 1 //8
                }
                if json["validaval"].boolValue{
                    myParam.validAval = json["validaval"].boolValue
                    jsonOk += 1 //9
                }
                if json["validserie"].boolValue{
                    myParam.validSerie = json["validserie"].boolValue
                    jsonOk += 1 //10
                }
                if json["validturma"].boolValue{
                    myParam.validTurma = json["validturma"].boolValue
                    jsonOk += 1 //11
                }
                if json["status"].intValue > -1{
                    myParam.status = json["status"].intValue
                    myAluno.Status = myParam.status
                    jsonOk += 1 //12
                }
                if json["cpf"].stringValue.isEmpty==false{
                    myAluno.CPF = json["cpf"].stringValue
                    jsonOk += 1 //13
                }
                if json["email"].stringValue.isEmpty==false{
                    myAluno.email = json["email"].stringValue
                    jsonOk += 1 //14
                }
                if json["datainad"].stringValue.isEmpty==false{
                    myAluno.datainad = json["datainad"].stringValue
                    jsonOk += 1 //15
                }
                if json["foto"].stringValue.isEmpty==false{
                    myAluno.foto = json["foto"].stringValue
                    jsonOk += 1 //16
                }
                if json["nome"].stringValue.isEmpty==false{
                    myAluno.Nome = json["nome"].stringValue
                    jsonOk += 1 //17
                }
                if json["idade"].intValue > -1{
                    myAluno.idade = json["idade"].intValue
                    jsonOk += 1 //18
                }
                if json["nascimento"].stringValue.isEmpty==false{
                    myAluno.Nascimento = json["nascimento"].stringValue
                    jsonOk += 1 //19
                }
                if json["plano"].stringValue.isEmpty==false{
                    myAluno.plano = json["plano"].stringValue
                    jsonOk += 1 //20
                }
                if json["proxvenc"].stringValue.isEmpty==false{
                    myAluno.proxvenc = json["proxvenc"].stringValue
                    jsonOk += 1 //21
                }
                if json["tolerancia"].intValue > -1{
                    myAluno.tolerancia = json["tolerancia"].intValue
                    jsonOk += 1 //22
                }
                if json["sexo"].intValue > -1{
                    myAluno.sexo = json["sexo"].intValue
                    jsonOk += 1 //23
                }
                if json["atraso"].stringValue.isEmpty==false{
                    myAluno.atraso = json["atraso"].intValue
                    jsonOk += 1 //24
                }
                parcela.clear()
                let dict = json["parc"].dictionaryValue
                if dict.count>0{
                    let list = dict["rows"]!.arrayValue
                    for item in list{
                        parcela.addParc(item["data"].stringValue, item["valor"].stringValue)
                    }
                }
               
                if jsonOk<24{
                    _=warning(view:self, title:"Erro", message:"JSON inválido nível: " + String(jsonOk), buttons:1)
                }else{
                    if self.pegaAval()==false{
                       return
                    }
                    if self.pegaAero()==false{
                        return
                    }
                    if self.pegaSerie()==false{
                        return
                    }
                    if self.pegaTurmas()==false{
                        return
                    }
                    if interstitial.isReady{
                        interstitial.present(fromRootViewController: self)
                    }
                    else{
                        if qtdFalhasGoogleAd>0{
                            performSegue(withIdentifier: "MenuController", sender: nil)
                            qtdFalhasGoogleAd = 0
                        }
                        else{
                            _ = warning(view: self, title: "Erro", message: "Rede sobrecarregada. Tente novamente", buttons: 1)
                            qtdFalhasGoogleAd += 1
                        }
                        
                    }
                    
                }
            }else{
                _ = warning(view: self, title: "Erro", message: "JSON de aluno e parâmetro inválido", buttons:1)
            }// JSON Ok
        }
        else{
            _ = warning(view: self, title: "Erro", message: resposta, buttons:1)
        }// contentType
    }// trataResp
    
    //Carrega Avaliações Funcionais
    func pegaAval()->Bool{
        if (myParam.accessAval && myParam.validAval) == false{
            return true
        }
        let job = httpJob()
        let aluno = config["user"]!
        let senha = config["password"]!
        let agora = currentDateTime()
        let authStr = authenticate(usr: aluno, pwd: senha, time: agora)
        job.setServer(server)
        job.setPath("/asp/aspgym.aspx")
        job.setParameters(["objeto":"aspAval","aluno":aluno,"timestamp":agora,"sha-256":authStr])
        rawAval = job.execute()
        if rawAval.isEmpty{
            _ = warning(view: self, title: "Erro", message: "Sem conexão com o servidor", buttons:1)
            lbConnect.setCaption(" ")
            return false
        }
        if job.getContentType().lowercased().contains("json")==false{
            myParam.validAval=false
            //print(rawAval)
            return true
        }
        return true // valid json
    }
    
    //Programa Aeróbio
    func pegaAero()->Bool{
        if (myParam.accessAero && myParam.validAero) == false{
            return true
        }
        let job = httpJob()
        let aluno = config["user"]!
        let senha = config["password"]!
        let agora = currentDateTime()
        let authStr = authenticate(usr: aluno, pwd: senha, time: agora)
        job.setServer(server)
        job.setPath("/asp/aspgym.aspx")
        job.setParameters(["objeto":"aspAero","aluno":aluno,"timestamp":agora,"sha-256":authStr, "dia":"8"])
        rawAero = job.execute()
        aero.clear()
        if rawAero.isEmpty{
            _ = warning(view: self, title: "Erro", message: "Servidor não respondeu", buttons: 1)
            lbConnect.setCaption(" ")
            return false
        }else{
            if job.getContentType().uppercased().contains("JSON"){
                //var jsonOk = 0
                if let _ = try? JSON(data: rawAero.data(using: .utf8)!){
                    return true
                }else{
                    myParam.validAero = false
                    return true
                }
            }else{
                myParam.validAero = false
                return true
            }
        }
    }
    
    // Série de Musculação
    func pegaSerie()->Bool{
        if (myParam.accessMusc && myParam.validSerie) == false{
            return true
        }
        let job = httpJob()
        let aluno = config["user"]!
        let senha = config["password"]!
        let agora = currentDateTime()
        let authStr = authenticate(usr: aluno, pwd: senha, time: agora)
        job.setServer(server)
        job.setPath("/asp/aspgym.aspx")
        job.setParameters(["objeto":"aspSerie","aluno":aluno,"timestamp":agora,"sha-256":authStr, "dia":"8"])
        rawSerie = job.execute()
        serie.clear()
        if rawAero.isEmpty{
            _ = warning(view: self, title: "Erro", message: "Servidor não respondeu", buttons: 1)
            lbConnect.setCaption(" ")
            return false
        }else{
            if job.getContentType().uppercased().contains("JSON"){
                //var jsonOk = 0
                if let _ = try? JSON(data: rawSerie.data(using: .utf8)!){
                    return true
                }else{
                    myParam.validSerie = false
                    return true
                }
            }else{
                myParam.validSerie = false
                return true
            }
        }
    }
    
    // Turmas
    func pegaTurmas()->Bool{
        if (myParam.accessTurma && myParam.validTurma) == false{
            return true
        }
        let job = httpJob()
        let aluno = config["user"]!
        let senha = config["password"]!
        let agora = currentDateTime()
        let authStr = authenticate(usr: aluno, pwd: senha, time: agora)
        job.setServer(server)
        job.setPath("/asp/aspgym.aspx")
        job.setParameters(["objeto":"aspTurma","aluno":aluno,"timestamp":agora,"sha-256":authStr, "dia":"8"])
        rawTurmas = job.execute()
        if rawTurmas.isEmpty{
            _ = warning(view: self, title: "Erro", message: "Servidor não respondeu", buttons: 1)
            lbConnect.setCaption(" ")
            return false
        }else{
            if job.getContentType().uppercased().contains("JSON"){
                if let _ = try? JSON(data: rawTurmas.data(using: .utf8)!){
                    return true
                }else{
                    myParam.validTurma = false
                    return true
                }
            }else{
                myParam.validTurma = false
                return true
            }
        }
    }
    
    @IBAction func btnGoClick(_ sender: Any) {
        if AppIsValid==false{
            _ = warning(view: self, title: "Aplicativo Obsoleto", message: "A versão do seu APP está desatualziada. Por favor, atualize-a na Apple Store", buttons: 1)
            return
        }
        lbConnect.setCaption("Conectando Servidor1...")
        let job = httpJob()
        server = config["server1"]!
        //server = "192.168.0.5:9000"
        let aluno = config["user"]!
        let senha = config["password"]!
        let agora = currentDateTime()
        let authStr = authenticate(usr: aluno, pwd: senha, time: agora)
        //agora = agora.replacingOccurrences(of: " ", with: "%20")
        job.setServer(server)
        job.setPath("/asp/aspgym.aspx")
        job.setParameters(["objeto":"aspAuthAluno","aluno":aluno,"timestamp":agora,"sha-256":authStr])
        var resp = job.execute()
        if resp.isEmpty{
            lbConnect.setCaption("Conectando Servidor2...")
            server = config["server2"]!
            job.setServer(server)
            resp = job.execute()
            if resp.isEmpty{
                _ = warning(view: self, title: "Erro", message: "Sem conexão com o servidor", buttons:1)
                lbConnect.setCaption(" ")
                return
            }else{
                self.trataResp(resp, job.getContentType())
            }
        }else{
            self.trataResp(resp, job.getContentType())
        }
    }// action Go
    
    func createAndLoadInterstitial() -> GADInterstitial{
        let interstitial = GADInterstitial(adUnitID: adId)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        //print("interstitialWillPresentScreen")
        return
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        //print("interstitialWillDismissScreen")
        return
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        //print("interstitialDidDismissScreen")
        performSegue(withIdentifier: "MenuController", sender: nil)
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        //print("interstitialWillLeaveApplication")
        return
    }

    func AppValidate() {
        if jaChecouVersao{
            return
        }
        let job = httpJob()
        job.setServer("sysnetweb.com.br:4443")
        job.setProtocolHttps()
        job.setPath("/asp/versiongym.aspx")
        job.setParameters(["objeto":"aspGetMinValidVersion","version":AppVersion])
        let resp = job.execute()
        //print("Resp: "+resp)
        //print("Lasterror: "+job.getLastError())
        if resp.count>0{
            jaChecouVersao = true
        }
        if resp == "OBSOLETE VERSION"{
           AppIsValid = false
        }
        return
    }
}
