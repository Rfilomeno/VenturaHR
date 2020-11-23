//
//  RegisterViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit
import JMMaskTextField_Swift

protocol validateProtocol: NSObjectProtocol {
    func validateFields() -> Bool
}

extension validateProtocol {
    func validateFields() -> Bool { return false }
}

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var cpfLabel: UILabel!
    @IBOutlet weak var cpfField: JMMaskTextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactField: UITextField!
    @IBOutlet weak var passorwdField: UITextField!
    @IBOutlet weak var confirmPassowrdField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    let repository = UserRepository.shared
    public var isCompany = false
    
    public var editMode = false
    
    weak var delegate: ModalViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.delegate = self
        setupView()
        if editMode {
            setupEditMode()
        }
    }

    private func setupView(){
        if isCompany {
            nameLabel.text = "Razão Social:"
            cpfLabel.text = "CNPJ:"
            cpfField.maskString = "00.000.000/0000-00"
            contactLabel.isHidden = false
            contactField.isHidden = false
        }
        
        
    }
    
    
    func showLoadingIndicator(_ show: Bool){
        self.loadingIndicator.isHidden = !show
        show ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating() 
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        view.endEditing(true)
        if validateFields(){
            if editMode {
                editUser()
                return
            } else if isCompany {
                registerCompany()
            } else {
                registerCandidate()
            }
        }
    }
    
    private func registerCompany(){
        let company = Company()
        company.name = nameField.text ?? ""
        company.email = emailField.text ?? ""
        company.contactName = contactField.text ?? ""
        company.cnpj = cpfField.text ?? ""
        company.password = passorwdField.text ?? ""
        company.phone = phoneField.text ?? ""
        company.address = addressField.text ?? ""
        
        showLoadingIndicator(true)
        repository.createFirebaseUserLogin(user: company)
        
    }
    
    private func registerCandidate(){
        let candidate = Candidate()
        candidate.name = nameField.text ?? ""
        candidate.email = emailField.text ?? ""
        candidate.cpf = cpfField.text ?? ""
        candidate.password = passorwdField.text ?? ""
        candidate.phone = phoneField.text ?? ""
        candidate.address = addressField.text ?? ""
        
        showLoadingIndicator(true)
        repository.createFirebaseUserLogin(user: candidate)
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
    
    
    func alertEmail(){
        
        let alert = UIAlertController(title: "Email invalido", message: "O Email já está registrado em nossa base de dados ou é invalido.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension RegisterViewController: validateProtocol {
    
    func validateFields() -> Bool {
        var validator = true
        if nameField.text?.isEmpty ?? true {
            nameField.layer.borderWidth = 1
            nameField.layer.borderColor = UIColor.red.cgColor
            validator = false
        } else {
            nameField.layer.borderWidth = 0
            nameField.layer.borderColor = UIColor.black.cgColor
        }
        if emailField.text?.isEmpty ?? true {
            emailField.layer.borderWidth = 1
            emailField.layer.borderColor = UIColor.red.cgColor
            validator = false
        } else {
            emailField.layer.borderWidth = 0
            emailField.layer.borderColor = UIColor.black.cgColor
        }
        if cpfField.text?.isEmpty ?? true {
            cpfField.layer.borderWidth = 1
            cpfField.layer.borderColor = UIColor.red.cgColor
            validator = false
        } else {
            cpfField.layer.borderWidth = 0
            cpfField.layer.borderColor = UIColor.black.cgColor
        }
        if phoneField.text?.isEmpty ?? true {
            phoneField.layer.borderWidth = 1
            phoneField.layer.borderColor = UIColor.red.cgColor
            validator = false
        } else {
            phoneField.layer.borderWidth = 0
            phoneField.layer.borderColor = UIColor.black.cgColor
        }
        if addressField.text?.isEmpty ?? true {
            addressField.layer.borderWidth = 1
            addressField.layer.borderColor = UIColor.red.cgColor
            validator = false
        } else {
            addressField.layer.borderWidth = 0
            addressField.layer.borderColor = UIColor.black.cgColor
        }
        if contactField.text?.isEmpty ?? true && isCompany {
            contactField.layer.borderWidth = 1
            contactField.layer.borderColor = UIColor.red.cgColor
            validator = false
        } else {
            contactField.layer.borderWidth = 0
            contactField.layer.borderColor = UIColor.black.cgColor
        }
        if passorwdField.text?.isEmpty ?? true {
            passorwdField.layer.borderWidth = 1
            passorwdField.layer.borderColor = UIColor.red.cgColor
            validator = false
        } else {
            passorwdField.layer.borderWidth = 0
            passorwdField.layer.borderColor = UIColor.black.cgColor
        }
        if confirmPassowrdField.text?.isEmpty ?? true {
            confirmPassowrdField.layer.borderWidth = 1
            confirmPassowrdField.layer.borderColor = UIColor.red.cgColor
            validator = false
        } else {
            confirmPassowrdField.layer.borderWidth = 0
            confirmPassowrdField.layer.borderColor = UIColor.black.cgColor
        }
        if (passorwdField.text != confirmPassowrdField.text) {
            passorwdField.layer.borderWidth = 1
            confirmPassowrdField.layer.borderWidth = 1
            passorwdField.layer.borderColor = UIColor.red.cgColor
            confirmPassowrdField.layer.borderColor = UIColor.red.cgColor
            validator = false
        }
        return validator
    }
}

extension RegisterViewController: repositoryProtocol{
    func returnFromRepository(resposta: Bool) {
        if resposta {
            showLoadingIndicator(false)
            self.navigationController?.popViewController(animated: true)
        } else {
            showLoadingIndicator(false)
            emailField.layer.borderWidth = 1
            emailField.layer.borderColor = UIColor.red.cgColor
            self.alertEmail()
        }
    }
}
