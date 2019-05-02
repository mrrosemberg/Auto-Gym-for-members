//
//  MenuController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 09/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class MenuController: UIViewController {
    
    @IBOutlet weak var lbSenha: UILabel!
    @IBOutlet weak var lbAval: UILabel!
    @IBOutlet weak var lbAero: UILabel!
    @IBOutlet weak var lbMusc: UILabel!
    @IBOutlet weak var lbTurma: UILabel!
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var btnSenha: UIButton!
    @IBOutlet weak var btnAval: UIButton!
    @IBOutlet weak var btnAero: UIButton!
    @IBOutlet weak var btnMusc: UIButton!
    @IBOutlet weak var btnTurma: UIButton!
    @IBOutlet weak var btnUser: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //stackVC = [self]
        lbTurma.isEnabled = (myParam.accessTurma && myParam.validTurma)
        btnTurma.isEnabled = (myParam.accessTurma && myParam.validTurma)
        lbMusc.isEnabled = (myParam.accessMusc && myParam.validSerie)
        btnMusc.isEnabled = (myParam.accessMusc && myParam.validSerie)
        lbAero.isEnabled = (myParam.accessAero && myParam.validAero)
        btnAero.isEnabled = (myParam.accessAero && myParam.validAero)
        lbAval.isEnabled = (myParam.accessAval && myParam.validAval)
        btnAval.isEnabled = (myParam.accessAval && myParam.validAval)
        lbSenha.isEnabled = (myAluno.Status==2)
        btnSenha.isEnabled = (myAluno.Status==2)
    }
    
}
