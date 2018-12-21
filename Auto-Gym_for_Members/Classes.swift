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
    
    func getFileURL(fileName: String) -> String {
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
    
    
}
