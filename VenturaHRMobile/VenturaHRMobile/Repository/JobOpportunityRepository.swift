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
}
