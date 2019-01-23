//
//  Funcoes.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 17/12/18.
//  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit

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
                    urlString = urlString + ("?" + key + "=") + value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                }else{
                    urlString = urlString + ("&" + key + "=") + value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
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

open class Aluno {
     public var Nome = ""
     public var CPF = ""
     public var Nascimento = ""
     public var foto = ""
     public var proxvenc = ""
     public var plano = ""
     public var email = ""
     public var idade = 0
     public var Status = 0
     public var tolerancia = 0
     public var atraso = 0
     public var datainad = ""
     public var sexo = 0
}

open class Param{
     public var accessAero = false
     public var accessErgo = false
     public var accessFin = false
     public var accessMusc = false
     public var accessTurma = false
     public var accessAval = false
     public var status = 0
     public var validAero = false
     public var validAval = false
     public var validSerie = false
     public var validTurma = false
}

public class parc{
    public var data = ""
    public var valor = ""
    
    init(_ data:String, _ valor:String){
        self.data = data
        self.valor = valor
    }
}

open class Parcela{
    public var parcela = [parc]()
    
    public func addParc(_ data:String, _ valor:String){
        parcela.append(parc(data,valor))
    }
    
    public func clear(){
        parcela.removeAll()
    }
    
    public func getParc(_ i : Int)->parc{
        return parcela[i]
    }
    
}

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
    var section : String
    var linhas: [linha]
    
    init(_ section:String, _ linhas: [linha]){
        self.section = section
        self.linhas = linhas
    }
    
}

open class ListaSecao{
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

public class Turma{
    //Type structTurma (turma As String, Professor As String, Sala As String, Atividade As String, Inicio As String, Fim As String, Matriculado As Boolean)
    var turma:String
    var professor:String
    var sala:String
    var atividade:String
    var inicio:String
    var fim:String
    var matriculado:Bool
    
    init(_ turma:String, _ professor:String, _ sala:String, _ atividade:String, _ inicio:String, _ fim:String, _ matriculado:Bool){
        self.turma = turma
        self.professor = professor
        self.sala = sala
        self.atividade = atividade
        self.inicio = inicio
        self.fim = fim
        self.matriculado = matriculado
    }
}

open class Turmas{
    public var turma : [Turma]
    public var dayOfWeek = ""
    
    init(_ turma: [Turma])
    {
        self.turma = turma
    }
    
    public func addTurma(_ turma: Turma){
        self.turma.append(turma)
    }
    
    public func clear(){
        turma.removeAll()
    }
}

public class MyMusc{
    public var diaourotina = ""
    public var fim = ""
    public var inicio = ""
    public var nivel = ""
    public var obs = ""
    public var professor = ""
    public var programanum = 0
    public var qtdimp = 0
    public var rotina = ""
    public var tserie = ""
    public var ultimp = ""
    public var idade = 0
    public var dia = 0
    public var selectedSeq = 0
}

public class MyAero{
    public var diaourotina = ""
    public var fim = ""
    public var inicio = ""
    public var nivel = ""
    public var obs = ""
    public var professor = ""
    public var aeronum = 0
    public var qtdimp = 0
    public var rotina = ""
    public var ultimp = ""
    public var idade = 0
    public var dia = 0
    public var zonaalvo = ""
    public var selectedSeq = 0
}

public class Exercicio{
    public var seq = 0
    public var exercicio = ""
    public var regiao = ""
    public var series = ""
    public var carga = ""
    public var repeticoes = ""
    public var regulagem = ""
    public var segunda = false
    public var terca = false
    public var quarta = false
    public var quinta = false
    public var sexta = false
    public var sabado = false
    public var domingo = false
}

public class ExAero{
    public var seq = 0
    public var exbio = ""
    public var fc = ""
    public var tempo = ""
    public var borg = ""
    public var regulagem = ""
    public var segunda = false
    public var terca = false
    public var quarta = false
    public var quinta = false
    public var sexta = false
    public var sabado = false
    public var domingo = false
}

open class Serie {
   public var exercicios : [Exercicio]
   public var header : MyMusc
   
    init(_ exercicios: [Exercicio],_ header: MyMusc)
    {
        self.exercicios = exercicios
        self.header = header
    }
    
    public func addExercicio(_ exercicio: Exercicio){
        self.exercicios.append(exercicio)
    }
    
    public func clear(){
        exercicios.removeAll()
    }
}

open class Aero {
    public var exercicios : [ExAero]
    public var header : MyAero
    
    init(_ exercicios: [ExAero],_ header: MyAero)
    {
        self.exercicios = exercicios
        self.header = header
    }
    
    public func addExercicio(_ exercicio: ExAero){
        self.exercicios.append(exercicio)
    }
    
    public func clear(){
        exercicios.removeAll()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
