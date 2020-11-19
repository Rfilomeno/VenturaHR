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
    @IBOutlet var newAccountButton: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailField.text = ""
        passwordField.text = ""
    }

    @IBAction func LoginButtonAction(_ sender: Any) {
        let user = LoginRepository.proceedLogin(email: emailField.text ?? "", password: passwordField.text ?? "")
        if let userLogged = user{
            let repository = UserRepository.shared
            repository.setCurrentUser(user: userLogged)
            let tabBar = HomeStrategy.getTabBar(for: userLogged)
            self.present(tabBar, animated: true)
        } else {
            print("Deu ruim no loggin")
        }
        
    }
    
    
    @IBAction func newAccountButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Qual tipo de Conta deseja criar?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "PJ", style: .default, handler: { action in
        let controller = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
            controller.isCompany = true
        self.navigationController?.pushViewController(controller, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "PF", style: .default, handler: { action in
        let controller = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        controller.isCompany = false
        self.navigationController?.pushViewController(controller, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "cancelar", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
    @IBAction func continueWithoutLogginAction(_ sender: Any) {
        let controller = JobOpportunityListViewController(nibName: "JobOpportunityListViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

