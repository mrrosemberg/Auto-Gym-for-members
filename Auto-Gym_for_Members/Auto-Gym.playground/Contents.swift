import UIKit
import Alamofire
import SwiftyJSON

class GetData{
    
    var url = ""
    var parameters = ["":""]
    var lastError = ""
    var returnedData = ""
    
    func call(completion: @escaping (String) -> Void){
        var alamoFireManager : SessionManager?
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        let param = self.parameters
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)

        alamoFireManager!.request(self.url, method:.get, parameters: param)
            .validate(statusCode: 200..<300)
            .responseString { response in
                if (response.result.isFailure) {
                    self.lastError = "Error contacting server"
                    completion((response.error?.localizedDescription)!)
                }
                if (response.result.isSuccess) {
                    self.lastError = ""
                    completion(response.result.value!)
                }
                
        }//alamofireManager
        
    }
    
}

extension URLSession {
    func synchronousDataTask(urlrequest: URLRequest) -> (data: Data?, response: URLResponse?, error: Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: urlrequest) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
}
/*let netCall = GetData()
netCall.url = "http://192.168.0.5:9000"
netCall.parameters = ["aluno":"006199"]
netCall.call(){ response in
    if netCall.lastError.isEmpty{
       print(response)
      }else{
       print(response)
    }
}
let url = NSURLComponents()
url.scheme = "http"
url.host="192.168.0.5:9000"
url.path="/vfp/ajaxalunotreino.avfp"
let queryItems = [NSURLQueryItem(name: "aluno", value: "006199")]
url.queryItems = queryItems as [URLQueryItem]
var uri = url.url!
url.host = "192.168.0.5"
var request = URLRequest(url: uri)
request.httpMethod = "GET"
request.timeoutInterval = 15 // 15 seconds
var uri2 = url.url!
var request2 = URLRequest(url: uri2)
request.httpMethod = "GET"
request.timeoutInterval = 15 // 15 seconds
let (data, response, error) = URLSession.shared.synchronousDataTask(urlrequest: request)
if let erro = error{
    print("Erro no primeiro servidor" + erro.localizedDescription)
    let (data2, response2, error2) = URLSession.shared.synchronousDataTask(urlrequest: request2)
    if let erro2 = error2{
       print("Erro no segundo servidor" + erro2.localizedDescription)
    }else{
        let outStr = String(data: data2!, encoding: String.Encoding.utf8)
        print("Resposta do Segundo Servidor: " + outStr!)
    }
    
}else{
    let outStr = String(data: data!, encoding: String.Encoding.utf8)
    print("Resposta do Primeiro Servidor: " + outStr!)
}*/
/*let date = NSDate()
print(date)
let formatter = DateFormatter()
// initially set the format based on your datepicker date / server String
formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
formatter.timeZone = TimeZone(identifier: "UTC")
let myString = formatter.string(from: Date()) // string purpose I add here
// convert your string to date
print(myString)
let yourDate = formatter.date(from: myString)
//then again set the date format whhich type of output you need
formatter.dateFormat = "dd-MMM-yyyy"
// again convert your date to string
let myStringafd = formatter.string(from: yourDate!)

print(myStringafd)*/

public class linha {
    public var color = UIColor.white
    public var text = ""
    init(_ color:UIColor, _ text:String){
        self.color = color
        self.text = text
    }
    init(_ text:String){
        self.color = UIColor.white
        self.text = text
    }
}

public class lista{
    public var section : String
    public var linhas: [linha]
    
    init(_ section:String, _ linhas: [linha]){
        self.section = section
        self.linhas = linhas
    }
    
}

open class ListaAluno{
    public var elemento : [lista]
    
    init(_ elemento: [lista])
    {
        self.elemento = elemento
    }
    
    public func addLinha(_ elemento: lista){
        self.elemento.append(elemento)
    }
    
    public func clear(){
        elemento.removeAll()
    }
    
}


let list = lista("Dados do Aluno",[linha("Nome: Marcio")])

list.linhas.append(linha("E-mail: marcio@sysnetweb.com.br"))

list.linhas.append(linha("CPF: 909.644.487-04"))
let alData = ListaAluno([list])
alData.addLinha(lista("Parcelas do Plano",[linha("Data: 20/10/2018, Valor: 209,90")]))
alData.elemento[1].linhas.append(linha("Data: 20/11/2018, Valor: 210,00"))
alData.elemento[1].linhas.append(linha("Data: 20/12/2018, Valor: 210,10"))
for i in alData.elemento{
    print("Seção: " + i.section)
    for j in i.linhas{
        print("       " + j.text)
    }
}

