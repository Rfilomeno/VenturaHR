//
//  LoginRepository.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import Firebase


public class LoginRepository{
    
    //MARK: Mock
    public static func proceedLogin(email:String, password:String) -> User? {
        
        let repository = UserRepository.shared
        
        if let user = repository.getUser(email: email){
            return (user.password == password ? user : nil)
        }
        
        return nil

    }
    
    //MARK: Firebase Create userLogin
    
    public static func createFirebaseLogin(email:String, password:String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error == nil {
                
            }
        }
        
    }
    
    
}
