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
    @IBOutlet weak var registerButton: UIButton!
    let repository = UserRepository.shared
    public var isCompany = false
    
    public var editMode = false
    
    weak var delegate: ModalViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        if editMode {
            setupEditMode()
        }
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
        if editMode {
            editUser()
            return
        } else if isCompany {
            registerCompany()
        } else {
            registerCandidate()
        }
    }
    
    private func registerCompany(){
        let company = Company(name: nameField.text ?? "", email: emailField.text ?? "", contactName: contactField.text ?? "", cnpj: cpfField.text ?? "", password: passorwdField.text ?? "")
        company.phone = phoneField.text ?? ""
        company.address = addressField.text ?? ""
        
        repository.addUser(user: company)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func registerCandidate(){
        let candidate = Candidate(name: nameField.text ?? "", email: emailField.text ?? "", cpf: cpfField.text ?? "", password: passorwdField.text ?? "")
        candidate.phone = phoneField.text ?? ""
        candidate.address = addressField.text ?? ""
        
        repository.addUser(user: candidate)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: EditMode
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private func setupEditMode(){
        titleLabel.text = "Editar dados"
        registerButton.setTitle("Salvar", for: .normal)
        emailField.isEnabled = false
        emailField.backgroundColor = .lightGray
        passorwdField.isEnabled = false
        passorwdField.backgroundColor = .lightGray
        confirmPassowrdField.isEnabled = false
        confirmPassowrdField.backgroundColor = .lightGray
        if isCompany{
            let company = repository.getCurrentCompany()
            nameField.text = company?.name
            emailField.text = company?.email
            cpfField.text = company?.cnpj
            phoneField.text = company?.phone
            addressField.text = company?.address
            contactField.text = company?.contactName
            passorwdField.text = company?.password
            confirmPassowrdField.text = company?.password
        } else {
            let candidate = repository.getCurrentCandidate()
            nameField.text = candidate?.name
            emailField.text = candidate?.email
            cpfField.text = candidate?.cpf
            phoneField.text = candidate?.phone
            addressField.text = candidate?.address
            passorwdField.text = candidate?.password
            confirmPassowrdField.text = candidate?.password
        }
        
    }
    
    private func editUser(){
        if let company = repository.getCurrentCompany(){
            company.name = nameField.text!
            company.contactName = contactField.text!
            company.cnpj = cpfField.text
            company.phone = phoneField.text
            company.address = addressField.text
            repository.addUser(user: company)
        }
        if let candidate = repository.getCurrentCandidate(){
            candidate.name = nameField.text!
            candidate.cpf = cpfField.text
            candidate.phone = phoneField.text
            candidate.address = addressField.text
            repository.addUser(user: candidate)
        }
        self.delegate?.returnFromModal()
        self.dismiss(animated: true, completion: nil)
    }
    
}
