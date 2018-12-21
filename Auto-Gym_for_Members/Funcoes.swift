//
//  warning.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 12/12/18.
//  Copyright © 2018 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit

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
