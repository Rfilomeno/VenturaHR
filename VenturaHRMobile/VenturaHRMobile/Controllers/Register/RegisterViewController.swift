//
//  RegisterViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var cpfLabel: UILabel!
    @IBOutlet weak var cpfField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactField: UITextField!
    @IBOutlet weak var passorwdField: UITextField!
    @IBOutlet weak var confirmPassowrdField: UITextField!
    
    public var isCompany = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView(){
        if isCompany {
            nameLabel.text = "Razão Social:"
            cpfLabel.text = "CNPJ:"
            contactLabel.isHidden = false
            contactField.isHidden = false
        }
    }
    @IBAction func registerButtonAction(_ sender: Any) {
        if isCompany {
            registerCompany()
        } else {
            registerCandidate()
        }
    }
    
    private func registerCompany(){
        let company = Company(name: nameField.text ?? "", email: emailField.text ?? "", contactName: contactField.text ?? "", cnpj: cpfField.text ?? "", password: passorwdField.text ?? "")
        company.phone = phoneField.text ?? ""
        company.address = addressField.text ?? ""
        
        let repository = UserRepository.shared
        repository.addUser(user: company)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func registerCandidate(){
        let candidate = Candidate(name: nameField.text ?? "", email: emailField.text ?? "", cpf: cpfField.text ?? "", password: passorwdField.text ?? "")
        candidate.phone = phoneField.text ?? ""
        candidate.address = addressField.text ?? ""
        
        let repository = UserRepository.shared
        repository.addUser(user: candidate)
        self.navigationController?.popViewController(animated: true)
    }
    
}
