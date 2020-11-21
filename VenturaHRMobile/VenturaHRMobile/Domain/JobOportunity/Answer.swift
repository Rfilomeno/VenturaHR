//
//  Answer.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation

public class Answer{
    
    let id: String
    let candidate:Candidate
    let skills:[Skill]
    var answerDate: String
    var candidateScore: Double {
        var result: Double = 0
        var weights: Double = 0
        for skill in skills {
            weights += skill.weight
            result += (skill.candidateAnswer * skill.weight)
        }
        return (result/weights)
    }
    var minScore: Double {
        var weights: Double = 0
        var pmd: Double = 0
        for skill in skills {
            weights += skill.weight
            pmd += skill.PMD * skill.weight
        }
        return pmd/weights
    }
    var gotMinScore: Bool {
        var haveMandatorySkills = true
        for skill in skills {
            if !skill.haveMandatory {
             return false
            }
        }
        return candidateScore >= minScore && haveMandatorySkills
    }
    
    init(candidate:Candidate, skills:[Skill]){
        self.id = UUID().uuidString
        self.candidate = candidate
        self.skills = skills
        self.answerDate = DateHelper.getCurrentDate()
        
    }
   
    
}
