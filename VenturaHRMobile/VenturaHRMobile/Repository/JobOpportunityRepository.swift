//
//  JobOpportunityRepository.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 18/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation

public class JobOpportunityRepository {
    
    var jobList: [JobOpportunity]
    
    private init(){
        jobList = []
        
        //MOCK:
        jobList = MockHelper.getJobs()
        
    }
    
    static var shared: JobOpportunityRepository = {
        let instance = JobOpportunityRepository()
        return instance
    }()
    
    public func addJobOpportunity(job: JobOpportunity){
        self.jobList.append(job)
    }
    
    public func getJobList() -> [JobOpportunity]{
        jobList
    }
    
    public func getJobList(from company: Company) -> [JobOpportunity]{
        return jobList.filter({$0.companyEmail == company.email})
    }
    public func getJobList(from cadidate: Candidate) -> [JobOpportunity]{
        let jobsAnswered = jobList.filter({!($0.answers!.isEmpty)})
        return jobsAnswered.filter({$0.filterAnswer(candidate: cadidate)})
    }
    public func getJobList(by company: Company) -> [JobOpportunity]{
        
        return jobList.filter({$0.companyEmail == company.email})
    }
    
    public func addAnswerTo(job: JobOpportunity, answer: Answer){
        self.jobList.first(where: {$0.id == job.id})?.answers!.append(answer)
    }
    
    public func getCandidateAnswer(for job: JobOpportunity) -> Answer?{
        let repository = UserRepository.shared
        guard let candidate = repository.getCurrentCandidate() else {return nil}
        return job.answers?.filter({$0.candidateEmail == candidate.email}).first
    }
    public func removeJobOpportunity(job: JobOpportunity){
        jobList.removeAll(where: {$0.id == job.id})
    }
    public func removeCandidateAnswer(on job: JobOpportunity){
        let repository = UserRepository.shared
        if let candidate = repository.getCurrentCandidate(){
            jobList.filter({$0.id == job.id}).first?.answers!.removeAll(where: {$0.candidateEmail == candidate.email})
        }
    }
}
