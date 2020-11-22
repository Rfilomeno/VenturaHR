//
//  JobOpportunity.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation

public class JobOpportunity {
    
    let id:String
    let companyEmail:String
    var title: String
    var description:String
    var answers:[Answer]
    var skills: [Skill]
    let publicationDate: String
    let expirationDate: String
    var stillValid = true
    
    
    init(companyEmail:String, title: String, description:String, skills: [Skill]){
        
        self.id = UUID().uuidString
        self.companyEmail = companyEmail
        self.title = title
        self.description = description
        self.answers = []
        self.skills = skills
        self.publicationDate = DateHelper.getCurrentDate()
        self.expirationDate = DateHelper.getExpirationDate()
    }
    
    public func filterSkills(by text: String) -> Bool{
        let result = self.skills.filter({$0.name.uppercased().contains(text.uppercased())})
        return !result.isEmpty
    }
    public func filterAnswer(candidate: Candidate) -> Bool{
        let result = self.answers.filter({$0.candidate.email == candidate.email})
           return !result.isEmpty
       }
}
