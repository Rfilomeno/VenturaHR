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
    @IBOutlet weak var alertLoginFailLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var loginRepository = LoginRepository.shared
    var email: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginRepository.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailField.text = ""
        passwordField.text = ""
        alertLoginFailLabel.isHidden = true
    }
    func showLoadingIndicator(_ show: Bool){
        self.loadingIndicator.isHidden = !show
        show ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
    }
    @IBAction func LoginButtonAction(_ sender: Any) {
        showLoadingIndicator(true)
        view.endEditing(true)
        alertLoginFailLabel.isHidden = true
        self.email = emailField.text ?? ""
        let user = loginRepository.proceedLogin(email: emailField.text ?? "", password: passwordField.text ?? "")
    }
    
    func presentRegisterController(forCompany: Bool){
         let controller = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        controller.isCompany = forCompany
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func newAccountButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Qual tipo de Conta deseja criar?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Empresa", style: .default, handler: { action in
            self.presentRegisterController(forCompany: true)
        }))
        alert.addAction(UIAlertAction(title: "Candidato", style: .default, handler: { action in
            self.presentRegisterController(forCompany: false)
        }))
        alert.addAction(UIAlertAction(title: "cancelar", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
   
    @IBAction func continueWithoutLogginAction(_ sender: Any) {
        let controller = JobOpportunityListViewController(nibName: "JobOpportunityListViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ViewController: repositoryProtocol{
    func returnFromRepository(resposta: Bool) {
        showLoadingIndicator(false)
        if resposta {
            let repository = UserRepository.shared
            if let uemail = email, let userLogged = repository.getUser(email: uemail ){
            
                repository.setCurrentUser(user: userLogged)
                let tabBar = HomeStrategy.getTabBar(for: userLogged)
                self.present(tabBar, animated: true)
            } else {
                alertLoginFailLabel.isHidden = false
            }
        } else {
            alertLoginFailLabel.isHidden = false
        }
    }
}
