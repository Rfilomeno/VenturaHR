//
//  LoginRepository.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

public class LoginRepository{
    
    private var userRepository = UserRepository.shared
    private var user: User?
    var delegate: repositoryProtocol?
    
    static var shared: LoginRepository = {
        let instance = LoginRepository()
        return instance
    }()
    
    public func proceedLogin(email:String, password:String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
          guard let strongSelf = self else { return }
            
            if error != nil{
                self?.delegate?.returnFromRepository(resposta: false)
            } else {
                self?.delegate?.returnFromRepository(resposta: true)
          }
        }
    }
}
