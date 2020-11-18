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
    let company:Company
    var description:String
    var answers:[Answer]
    var skills: [Skill]
    let publicationDate: String
    
    init(company:Company, description:String, skills: [Skill]){
        
        self.id = UUID().uuidString
        self.company = company
        self.description = description
        self.answers = []
        self.skills = skills
        self.publicationDate = DateHelper.getCurrentDate()
    }
    
}
