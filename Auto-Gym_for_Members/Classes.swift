//
//  Funcoes.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 17/12/18.
//  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
//

import Foundation

open class Pessoa{
    var id = 0
    var nome = ""
    
    public func getId()->Int{
        return self.id
    }
    
    public func setId(_ id:Int){
        self.id = id
    }

    public func getNome()->String{
        return self.nome
    }

    public func setNome(_ nome:String){
        self.nome = nome
    }
}

open class File {
    var fileName: String
    var fileExt: String
    var lastError = ""
    let DocumentDirURl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    init(fileName:String){
        self.fileName = fileName
        self.fileExt = "txt"
    }
    
    init(fileName:String, fileExt:String){
        self.fileName = fileName
        self.fileExt = fileExt
    }
    
    public func getLastError()->String{
        return self.lastError
    }
    
    private func getFileURL(fileName: String) -> String {
        let manager = FileManager.default
        let dirURL = try! manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return dirURL.appendingPathComponent(fileName).path
    }
    
    public func write(writeString:String)->Bool{
        let fileURL = DocumentDirURl.appendingPathComponent(self.fileName).appendingPathExtension(self.fileExt)
        var ret = true
        self.lastError = ""
        do {
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
          ret = false
          self.lastError = "Erro gravando arquivo " + self.fileName + "." + self.fileExt + "\n" + error.localizedDescription
        }
        return ret
    }
    
    public func write(writeDict:[String:String]){
        
        let filePath = self.getFileURL(fileName: self.fileName + "." + self.fileExt)
        self.lastError = ""
        NSKeyedArchiver.archiveRootObject(writeDict, toFile: filePath)
        return
    }
    
    public func read()->String{
        let fileURL = DocumentDirURl.appendingPathComponent(self.fileName).appendingPathExtension(self.fileExt).path
        self.lastError = ""
        //var readString: String?
        do {
            let readString = try String(contentsOfFile: fileURL, encoding: .utf8)
            return readString
           } catch let error as NSError {
             self.lastError = "Erro lendo arquivo " + self.fileName + "." + self.fileExt + "\n" + error.localizedDescription
            return ""
        }
    }
    
    public func read()->[String:String]{
       self.lastError = ""
       let filePath = self.getFileURL(fileName: self.fileName + "." + self.fileExt)
       let dict = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [String : String]
       if dict.count == 0 {self.lastError="Erro lendo arquivo " + self.fileName + "." + self.fileExt }
       return dict
    }
    
    public func exists()->Bool{
       self.lastError = ""
       let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
       let url = NSURL(fileURLWithPath: path)
       if let pathComponent = url.appendingPathComponent(self.fileName + "." + self.fileExt) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                return true
            } else {
                self.lastError = "File not Found"
            }
        } else {
            self.lastError = "Path not Found"
        }
        return false
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

open class httpJob{
    
    private var server = "127.0.0.1"
    private var lastError = ""
    private var path = ""
    private var parameters = ["":""]
    private var scheme = "http"
    private var contentType = "text/plain"
    private var timeOut = Double(15) // 15 seconds
    
    public func setProtocolHttp(){
        self.scheme = "http"
    }
    
    public func setProtocolHttps(){
        self.scheme = "https"
    }
    
    public func setServer(_ server:String){
        self.server = server
    }
    
    public func setPath(_ path:String){
        self.path = path
    }
    
    public func setParameters(_ param:[String:String]){
        self.parameters = param
    }
    
    public func setServer(_ timeoutInSeconds:Double){
        self.timeOut = timeoutInSeconds
    }
    
    public func getContentType()->String{
        return self.contentType
    }
    
    public func getLastError()->String{
        return self.lastError
    }
    
    private func makeUrl()->NSURL{
        //TODO melhorar a passagem dos parâmetros
        var urlString = self.scheme + "://" + self.server + self.path
        var count = 0
        if self.parameters.count>0{
            for (key, value) in self.parameters{
                if count==0{
                    urlString = urlString + ("?" + key + "=" + value)
                }else{
                    urlString = urlString + ("&" + key + "=" + value)
                }
                count += 1
            }
        }
        //print(urlString)
        let url = NSURL(string: urlString)
        return url!
    }
    
    public func execute()->String{
        let uri = self.makeUrl() as URL
        var request = URLRequest(url: uri)
        request.httpMethod = "GET"
        request.timeoutInterval = self.timeOut
        let (data, response, error) = URLSession.shared.synchronousDataTask(urlrequest: request)
        if let erro = error{
            self.lastError = erro.localizedDescription
            return ""
        }else{
            let ctype = response?.mimeType
            let outStr = String(data: data!, encoding: String.Encoding.utf8)
            self.contentType = ctype!
            self.lastError=""
            return outStr!
        }
    }
}
