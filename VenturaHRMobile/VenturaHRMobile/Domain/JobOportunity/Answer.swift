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
    var candidateScore: Int {
        var result = 0
        for skill in skills {
            result += (skill.candidateAnswer * skill.weight)
        }
        return result
    }
    
    init(candidate:Candidate, skills:[Skill]){
        self.id = UUID().uuidString
        self.candidate = candidate
        self.skills = skills
        self.answerDate = DateHelper.getCurrentDate()
        
    }
   
    
}
