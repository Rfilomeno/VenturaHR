//
//  JobOpportunity.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

public class JobOpportunity:  Identifiable, Codable {
    
    @DocumentID public var id:String? = UUID().uuidString
    var companyEmail:String?
    var title: String?
    var description:String?
    var answers:[Answer]? = []
    var skills: [Skill]? = []
    var publicationDate: String? = DateHelper.getCurrentDate()
    var expirationDate: String? = DateHelper.getExpirationDate()
    var stillValid: Bool? = true
    
    init(){}
    
    enum CodingKeys: String, CodingKey {
    case companyEmail
    case title
    case description
    case answers
    case skills
    case publicationDate
    case expirationDate
    case stillValid
    }
    
    public func filterSkills(by text: String) -> Bool{
        let result = self.skills?.filter({$0.name!.uppercased().contains(text.uppercased())})
        return !(result?.isEmpty ?? true)
    }
    public func filterAnswer(candidate: Candidate) -> Bool{
        let result = self.answers?.filter({$0.candidateEmail == candidate.email})
        return !(result?.isEmpty ?? true)
       }
}
