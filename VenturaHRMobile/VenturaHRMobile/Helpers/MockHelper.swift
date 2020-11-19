//
//  MockHelper.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 18/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation

public class MockHelper{
    
    public static func getJobs() -> [JobOpportunity]{
        let company = Company(name: "Apple", email: "apple.apple.com", contactName: "Steave", cnpj: nil, password: "123")
        let skill1 = Skill(name: "iOS", weight: 5)
        let skill2 = Skill(name: "Git", weight: 1)
        let skill3 = Skill(name: "ingles", weight: 2)
        let skill4 = Skill(name: "PODs", weight: 3)
        let skillList = [skill1, skill2, skill3, skill4]
        let job1 = JobOpportunity(company: company, title: "Analista de Sistemas", description: "Descrição Analista de Sistemas", skills: skillList)
        let job2 = JobOpportunity(company: company, title: "PO", description: "Descrição PO", skills: skillList)
        let job3 = JobOpportunity(company: company, title: "Analista de requisitos", description: "Descrição Analista de requisitos", skills: skillList)
        let job4 = JobOpportunity(company: company, title: "Agislista", description: "Descrição Agislista", skills: skillList)
        
        return [job1, job2, job3, job4]
    }
    
    
}
