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
    
    static var shared: UserRepository = {
        let instance = UserRepository()
        return instance
    }()
    
    private init(){
        let testCandidate = Candidate(name: "Rodrigo Filomeno", email: "rm.filomeno@gmail.com", cpf: "123456", password: "123456")
        let testCompany = Company(name: "Apple", email: "apple@apple.com", contactName: "Steave", cnpj: nil, password: "123456")
        candidates = [testCandidate]
        companys = [testCompany]
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
