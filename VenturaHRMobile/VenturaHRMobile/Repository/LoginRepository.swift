//
//  LoginRepository.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation

public class LoginRepository{
    
    
    public static func proceedLogin(email:String, password:String) -> Bool {
        
        return (email == "rm.filomeno@gmail.com" && password == "123456")
        
        
    }
    
}
