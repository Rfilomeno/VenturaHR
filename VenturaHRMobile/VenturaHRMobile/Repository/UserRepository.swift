//
//  UserRepository.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 18/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation

public class UserRepository {
    private var candidates: [Candidate]
    private var companys: [Company]
    private var currentUser: User?
    
    static var shared: UserRepository = {
        let instance = UserRepository()
        return instance
    }()
    
    private init(){
        //MOCK
        candidates = MockHelper.getCandidates()
        companys = MockHelper.getCompanys()
    }
    
    public func setCurrentUser(user: User){
        self.currentUser = user
    }
    public func getCurrentUser() -> User?{
        return currentUser
    }
    public func getUser(email: String) -> User?{
        if let user = self.candidates.first(where: {$0.email == email}) {
            return user
        }
        return self.companys.first(where: {$0.email == email})
    }
    
    public func addUser(user: User){
        if (user.type == .PF){
            self.candidates.append(user as! Candidate)
        } else {
            self.companys.append(user as! Company)
        }
    }
}
