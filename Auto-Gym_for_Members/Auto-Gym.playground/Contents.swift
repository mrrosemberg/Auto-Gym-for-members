import UIKit
import Alamofire
import SwiftyJSON

var alamoFireManager : SessionManager?
let configuration = URLSessionConfiguration.default
configuration.timeoutIntervalForRequest = 15
configuration.timeoutIntervalForResource = 15
let param = ["cnpj":"86.801.826/0001-75"]
alamoFireManager = Alamofire.SessionManager(configuration: configuration)

alamoFireManager!.request("http://sysnetweb.com.br:4080/vfp/validacnpj.avfp", method:.get, parameters: param)
    .validate(statusCode: 200..<300)
    .responseString {
        response in
        if response.result.isFailure {
            if let err = response.error?.localizedDescription {
                print("Sem conexão com o servidor "+err)
                return
            }
            print("Sem conexão com o servidor ")
            return
        } //endif result.isFailure
        if let data = response.data, let dados = String(data: data, encoding: .utf8){
         //   self.webData = dados
            if let cType = response.response?.allHeaderFields["Content-Type"] as? String {
        //        self.contentType = cType.lowercased()
            }
        }else{
            print("Sem resposta do servidor")
            return
        }//endif response.data
        //self.trataResp()
}//alamofireManager
