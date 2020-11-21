//
//  Skill.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation

public class Skill: NSCopying{
    
    
    
    let id:String
    let name:String
    var description:String?
    let weight: Int
    var candidateAnswer: Int = 0
    
    init(name:String, weight: Int){
        self.id = UUID().uuidString
        self.name = name
        self.weight = weight
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return Skill(name: name, weight: weight)
    }
}
