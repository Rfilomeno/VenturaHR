//
//  JobOpportunityRepository.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 18/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

public class JobOpportunityRepository {
    
    var jobList: [JobOpportunity]
    private var db = Firestore.firestore()
    
    private init(){
        jobList = []
        
    }
    
    static var shared: JobOpportunityRepository = {
        let instance = JobOpportunityRepository()
        return instance
    }()
    
    public func addJobOpportunity(job: JobOpportunity){
        
        if job.id == nil {
            job.id = job.myIdReference
        }
        self.jobList.append(job)
        let jobRef = db.collection("job").document("\(job.id!)")
        do{
         try jobRef.setData(from: job as! JobOpportunity, merge: true)
        }catch let error{
            print("Deu ruim ao criar Job")
        }
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
        job.answers?.append(answer)
        //self.jobList.first(where: {$0.id == job.id})?.answers!.append(answer)
        addJobOpportunity(job: job)
    }
    
    public func getCandidateAnswer(for job: JobOpportunity) -> Answer?{
        let repository = UserRepository.shared
        guard let candidate = repository.getCurrentCandidate() else {return nil}
        return job.answers?.filter({$0.candidateEmail == candidate.email}).first
    }
    public func removeJobOpportunity(job: JobOpportunity){
        jobList.removeAll(where: {$0.id == job.id})
        let jobRef = db.collection("job").document("\(job.id!)")
        jobRef.delete()
    }
    public func removeCandidateAnswer(on job: JobOpportunity){
        let repository = UserRepository.shared
        if let candidate = repository.getCurrentCandidate(){
            jobList.filter({$0.id == job.id}).first?.answers!.removeAll(where: {$0.candidateEmail == candidate.email})
            job.answers!.removeAll(where: {$0.candidateEmail == candidate.email})
            addJobOpportunity(job: job)
        }
    }
    
    public func fechJobData(){
        db.collection("job").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
            self.jobList = documents.compactMap { queryDocumentSnapshot -> JobOpportunity? in
            return try? queryDocumentSnapshot.data(as: JobOpportunity.self)
            }
        }
    }
}
