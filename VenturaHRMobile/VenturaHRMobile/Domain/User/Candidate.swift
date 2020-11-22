//
//  Candidate.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

public class Candidate: User, Identifiable, Codable {
    @DocumentID public var id: String?
    public var type: UserType? = .PF
    public var name: String?
    public var email: String?
    public var cpf: String?
    public var phone: String?
    public var address: String?
    public var password: String?
    
    init(){}
    
    enum CodingKeys: String, CodingKey {
    case id
    case type
    case name
    case email
    case cpf
    case phone
    case address
    case password
    }
    
}
