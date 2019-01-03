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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let file = File(fileName: "config", fileExt: "dat")
        if file.exists(){
           config = file.read()
            //TODO Alterar Título e Logo
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

}
