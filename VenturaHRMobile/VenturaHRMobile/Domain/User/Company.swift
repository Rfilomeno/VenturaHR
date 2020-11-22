//
//  Company.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

public class Company: User, Identifiable, Codable {
    
    @DocumentID public var id: String?
    public var type: UserType? = .PJ
    public var name: String?
    public var contactName: String?
    public var email: String?
    public var cnpj: String?
    public var phone: String?
    public var address: String?
    public var password: String?
    
    
    init(){}
    

    enum CodingKeys: String, CodingKey {
        case type
        case id
        case name
        case contactName
        case email
        case cnpj
        case phone
        case address
        case password
    }
    
}
