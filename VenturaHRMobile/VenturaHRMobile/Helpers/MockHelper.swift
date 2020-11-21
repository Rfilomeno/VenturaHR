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
        let skill1 = Skill(name: "iOS", weight: 5, pmd: 5)
        let skill2 = Skill(name: "Git", weight: 1, pmd: 2)
        let skill3 = Skill(name: "ingles", weight: 2, pmd: 3)
        let skill4 = Skill(name: "PODs", weight: 3, pmd: 5)
        let skillList = [skill1, skill2, skill3, skill4]
        skill1.candidateAnswer = 4
        skill2.candidateAnswer = 5
        skill3.candidateAnswer = 5
        skill4.candidateAnswer = 4
        let answeredSkill = [skill1, skill2, skill3, skill4]
        guard let candidate = MockHelper.getCandidates().first else {return []}
        let answer = Answer(candidate: candidate, skills: answeredSkill)
        let job1 = JobOpportunity(company: company, title: "Analista de Sistemas", description: "Descrição Analista de Sistemas", skills: skillList)
        job1.answers = [answer]
        let job2 = JobOpportunity(company: company, title: "PO", description: "Descrição PO", skills: skillList)
        let job3 = JobOpportunity(company: company, title: "Analista de requisitos", description: "Descrição Analista de requisitos", skills: skillList)
        let job4 = JobOpportunity(company: company, title: "Agislista", description: "Descrição Agislista", skills: skillList)
        
        return [job1, job2, job3, job4]
    }
    
    public static func getCandidates() -> [Candidate]{
        let testCandidate = Candidate(name: "Rodrigo Filomeno", email: "rm.filomeno@gmail.com", cpf: "123456", password: "123456")
        testCandidate.address = "Rua Maria Amalia, 264"
        testCandidate.phone = "(21) 99627-6007"
        let testCandidate2 = Candidate(name: "Cláudio Filomeno Júnior", email: "cfilomeno@msn.com", cpf: "123456", password: "123456")
        testCandidate2.address = "Rua do Piruca, 264"
        testCandidate2.phone = "(21) 98848-1195"
        return [testCandidate, testCandidate2]
        
    }
    public static func getCompanys() -> [Company]{
        let testCompany = Company(name: "Apple", email: "apple@apple.com", contactName: "Steave", cnpj: nil, password: "123456")
        return [testCompany]
        
    }
}
