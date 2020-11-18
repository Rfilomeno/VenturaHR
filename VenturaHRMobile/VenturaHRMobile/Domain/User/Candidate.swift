//
//  Candidate.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation

public class Candidate: User {
    
    public var id: String
    public var name: String
    public var email: String
    public var cpf: String?
    public var phone: String?
    public var address: String?
    
    init(name:String, email:String, cpf:String?) {
        self.id = UUID().uuidString
        self.name = name
        self.email = email
        self.cpf = cpf
        
    }
    
}
