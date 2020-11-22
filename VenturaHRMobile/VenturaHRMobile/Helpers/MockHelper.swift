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
        guard let company = MockHelper.getCompanys().first else {return []}
        let skill1 = Skill()
        skill1.name = "iOS"
        skill1.weight = 5
        skill1.PMD = 5
        let skill2 = Skill()
        skill2.name = "Git"
        skill2.weight = 1
        skill2.PMD = 2
        let skill3 = Skill()
        skill3.name = "ingles"
        skill3.weight = 2
        skill3.PMD = 3
        let skill4 = Skill()
        skill4.name = "PODS"
        skill4.weight = 3
        skill4.PMD = 4
        
        let skillList = [skill1, skill2, skill3, skill4]
        skill1.candidateAnswer = 4
        skill2.candidateAnswer = 5
        skill3.candidateAnswer = 5
        skill4.candidateAnswer = 4
        let answeredSkill = [skill1, skill2, skill3, skill4]
        guard let candidate = MockHelper.getCandidates().first else {return []}
        let answer = Answer()
        answer.candidateEmail = candidate.email
        answer.skills = answeredSkill
        let job1 = JobOpportunity()
        job1.companyEmail = company.email!
        job1.title = "Analista de Sistemas"
        job1.description = "Descrição Analista de Sistemas"
        job1.skills = skillList
        job1.answers = [answer]
        let job2 = JobOpportunity()
        job2.companyEmail = company.email!
        job2.title = "PO"
        job2.description = "Descrição PO"
        job2.skills = skillList
        let job3 = JobOpportunity()
        job3.companyEmail = company.email!
        job3.title = "Analista de requisitos"
        job3.description = "Descrição Analista de requisitos"
        job3.skills = skillList
        let job4 = JobOpportunity()
        job4.companyEmail = company.email!
        job4.title = "Agislista"
        job4.description = "Descrição Agislista"
        job4.skills = skillList
        
        return [job1, job2, job3, job4]
    }
    
    public static func getCandidates() -> [Candidate]{
        let testCandidate = Candidate()
        testCandidate.name = "Rodrigo Filomeno"
        testCandidate.email = "rm.filomeno@gmail.com"
        testCandidate.cpf = "123456"
        testCandidate.password = "123456"
        testCandidate.address = "Rua Maria Amalia, 264"
        testCandidate.phone = "(21) 99627-6007"
        
        let testCandidate2 = Candidate()
        testCandidate2.name = "Cláudio Filomeno Júnior"
        testCandidate2.email = "cfilomeno@msn.com"
        testCandidate2.cpf = "123456"
        testCandidate2.password = "123456"
        testCandidate2.address = "Rua do Piruca, 264"
        testCandidate2.phone = "(21) 98848-1195"
        
        return [testCandidate, testCandidate2]
        
    }
    public static func getCompanys() -> [Company]{
        let testCompany = Company()
        testCompany.name = "Apple"
        testCompany.email = "apple@apple.com"
        testCompany.contactName = "Steave"
        testCompany.cnpj = "12.098765/0001-29"
        testCompany.password = "123456"
        
        return [testCompany]
        
    }
}
