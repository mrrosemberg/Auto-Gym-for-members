//
//  userController.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 10/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import Foundation
import UIKit

class UserController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
    }
}
