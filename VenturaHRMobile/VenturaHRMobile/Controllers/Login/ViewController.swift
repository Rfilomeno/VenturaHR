//
//  ViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 06/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func LoginButtonAction(_ sender: Any) {
        
        if (LoginRepository.proceedLogin(email: emailField.text ?? "", password: passwordField.text ?? "")){
            print("Logou")
        } else {
            print("Deu Ruim")
        }
        
    }
    
}

