//
//  warning.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 12/12/18.
//  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift

func warning(view:UIViewController, title:String, message:String, buttons:Int)->Int {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    var ret:Int = 1
    
    if buttons==1 {
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in ret=1}))
    }else if buttons==2{
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: {action in ret=1}))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: {action in ret=2}))
    }else if buttons==3{
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: {action in ret=1}))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: {action in ret=2}))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: {action in ret=3}))
    }else{
         alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in ret=1}))
         alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: {action in ret=2}))
    }
    
    view.present(alert, animated: true)
    return ret
}

func base64ImgFromString(_ strBase64:String)->UIImage{
    let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
    let decodedimage = UIImage(data: dataDecoded)
    return decodedimage!
}

func authenticate(usr: String, pwd: String, time: String) -> String{
    var senha=""
    var authStr=""
    senha = (usr + pwd)
    //print(senha + " len: " + String(senha.count))
    let msg = Digest.sha512(senha.bytes)
    senha = msg.toHexString().uppercased()
    //print("Senha: " + senha)
    authStr = senha + usr + time
    let auth = Digest.sha256(authStr.bytes)
    authStr = auth.toHexString().uppercased()
    //print("User: " + usr + "; Agora: " + time)
    //print("authStr: " + authStr)
    return authStr
}

func currentDateTime() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    formatter.timeZone = TimeZone(identifier: "UTC")
    let myString = formatter.string(from: Date()) // string purpose I add here
    return myString
}

func diaDaSemanaAbreviado(_ dia: Date)->String{
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: dia)
    var ret = ""
    switch weekDay {
    case 1:
        ret = "Dom"
        break
    case 2:
        ret = "Seg"
        break
    case 3:
        ret = "Ter"
        break
    case 4:
        ret = "Qua"
        break
    case 5:
        ret = "Qui"
        break
    case 6:
        ret = "Sex"
        break
    case 7:
        ret = "Sab"
        break
    default:
        ret = ""
    }
    return ret
}

func hexToBytes(_ string: String) -> [UInt8] {
    let length = string.count
    if length < 2 {
        return [0]
    }
    var bytes = [UInt8]()
    let lowstr = string.lowercased()
    bytes.reserveCapacity(length/2)
    var index = lowstr.startIndex
    for _ in 0..<length/2 {
        let nextIndex = lowstr.index(index, offsetBy: 2)
        if let b = UInt8(lowstr[index..<nextIndex], radix: 16) {
            bytes.append(b)
        } else {
            return [0]
        }
        index = nextIndex
    }
    return bytes
}

func stringXor(_ str1 : String,_ str2 : String) -> String{ // assumes str2 will never be shorter than str1
    let data1 = hexToBytes(str1)
    let data2 = hexToBytes(str2)
    var bytes = [UInt8]()
    bytes.reserveCapacity(data1.count)
    for i in 0 ..< data1.count{
        let b = data1[i]^data2[i]
        bytes.append(b)
    }
    return bytes.toHexString().uppercased()
}

func makeNewPassword(_ novaSenha : String,_ usr : String,_ senhaAntiga : String,_ time : String) -> String{
    var senha = usr + senhaAntiga
    var msg = Digest.sha512(senha.bytes)
    var chave = msg.toHexString().uppercased() + time
    msg = Digest.sha512(chave.bytes)
    chave = msg.toHexString().uppercased()
    senha = usr + novaSenha
    msg = Digest.sha512(senha.bytes)
    var ret = msg.toHexString().uppercased()
    ret = stringXor(chave,ret)
    return ret
}
