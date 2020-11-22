//
//  Answer.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

public class Answer: Identifiable, Codable {
    
    @DocumentID public var id: String? = UUID().uuidString
    var candidateEmail: String?
    var skills:[Skill]? = []
    var answerDate: String? = DateHelper.getCurrentDate()
    var candidateScore: Double {
        var result: Double = 0
        var weights: Double = 0
        for skill in skills! {
            weights += skill.weight!
            result += (skill.candidateAnswer! * skill.weight!)
        }
        return (result/weights)
    }
    var minScore: Double {
        var weights: Double = 0
        var pmd: Double = 0
        for skill in skills! {
            weights += skill.weight!
            pmd += skill.PMD! * skill.weight!
        }
        return pmd/weights
    }
    var gotMinScore: Bool {
        var haveMandatorySkills = true
        for skill in skills! {
            if !skill.haveMandatory {
             return false
            }
        }
        return candidateScore >= minScore && haveMandatorySkills
    }
    
    
    init(){}
    
    enum CodingKeys: String, CodingKey {
    case id
    case candidateEmail
    case skills
    case answerDate
    }
   
    
}
