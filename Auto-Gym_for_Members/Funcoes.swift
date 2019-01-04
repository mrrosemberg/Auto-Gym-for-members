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
    print(senha + " len: " + String(senha.count))
    let msg = Digest.sha512(senha.bytes)
    senha = msg.toHexString().uppercased()
    print("Senha: " + senha)
    authStr = senha + usr + time
    let auth = Digest.sha256(authStr.bytes)
    authStr = auth.toHexString().uppercased()
    print("User: " + usr + "; Agora: " + time)
    print("authStr: " + authStr)
    return authStr
}

func currentDateTime() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    formatter.timeZone = TimeZone(identifier: "UTC")
    let myString = formatter.string(from: Date()) // string purpose I add here
    return myString
}
