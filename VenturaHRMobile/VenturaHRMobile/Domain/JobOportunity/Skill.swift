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
    let weight: Double
    let PMD: Double
    var candidateAnswer: Double = 0
    var haveMandatory: Bool {
        if PMD == 5{
            return candidateAnswer == 5
        }
        return true
    }
    var textAnswer: String {
        let skillDescription = ["Sem Conhecimento", "Júnior", "Pleno", "Senior", "Mestre Jedi"]
        return  skillDescription[Int(candidateAnswer-1)]
    }
    
    init(name:String, weight: Double, pmd: Double){
        self.id = UUID().uuidString
        self.name = name
        self.weight = weight
        self.PMD = pmd
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return Skill(name: name, weight: weight, pmd: PMD)
    }
}
