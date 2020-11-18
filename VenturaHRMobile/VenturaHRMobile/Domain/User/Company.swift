//
//  Company.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import UIKit

public class Company: User {
    public var type: UserType = .PJ
    public var id: String
    public var name: String
    public var contactName: String
    public var email: String
    public var cnpj: String?
    public var phone: String?
    public var address: String?
    public var password: String
    
    
    
    
    init(name:String, email:String, contactName: String, cnpj:String?, password: String) {
        self.id = UUID().uuidString
        self.name = name
        self.email = email
        self.cnpj = cnpj
        self.contactName = contactName
        self.password = password
    }
    
    
}
