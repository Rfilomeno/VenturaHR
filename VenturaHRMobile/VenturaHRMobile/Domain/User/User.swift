//
//  User.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation


public enum UserType {
    case PF, PJ
}

public protocol User {
    
    var id: String {get set}
    var name: String {get set}
    var email: String {get set}
    var phone: String? {get set}
    var address: String? {get set}
    var type: UserType {get set}
    var password: String {get set}
    
}
