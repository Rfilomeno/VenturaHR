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
    var title: String
    var description:String
    var answers:[Answer]
    var skills: [Skill]
    let publicationDate: String
    let expirationDate: String
    var stillValid = true
    
    
    init(company:Company, title: String, description:String, skills: [Skill]){
        
        self.id = UUID().uuidString
        self.company = company
        self.title = title
        self.description = description
        self.answers = []
        self.skills = skills
        self.publicationDate = DateHelper.getCurrentDate()
        self.expirationDate = DateHelper.getExpirationDate()
    }
    
}
