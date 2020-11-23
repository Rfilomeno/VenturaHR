//
//  Skill.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

public class Skill: NSCopying, Identifiable, Codable {
    
    public var id:String?
    var name:String?
    var description:String?
    var weight: Double?
    var PMD: Double?
    var candidateAnswer: Double? = 0
    var haveMandatory: Bool {
        if PMD == 5{
            return candidateAnswer == 5
        }
        return true
    }
    var textAnswer: String {
        let skillDescription = ["Sem Conhecimento", "Júnior", "Pleno", "Senior", "Mestre Jedi"]
        return  skillDescription[Int(candidateAnswer!-1)]
    }
    
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let newSkill = Skill()
        newSkill.id = UUID().uuidString
        newSkill.name = name
        newSkill.weight = weight
        newSkill.PMD = PMD
        return newSkill
    }
    
    init(){}
    
    enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case weight
    case PMD
    case candidateAnswer
    }
}
