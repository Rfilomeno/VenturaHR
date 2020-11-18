//
//  Skill.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation

public class Skill{
    
    let id:String
    let name:String
    var description:String?
    let weight: Int
    var candidateAnswer: Int?
    
    init(name:String, weight: Int){
        self.id = UUID().uuidString
        self.name = name
        self.weight = weight
    }
    
}
