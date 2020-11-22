//
//  UserRepository.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 18/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

public class UserRepository {
    private var candidates: [Candidate]
    private var companys: [Company]
    private var currentUser: User?
    private var db = Firestore.firestore()
    static var shared: UserRepository = {
        let instance = UserRepository()
        return instance
    }()
    
    private init(){
        //MOCK
        candidates = MockHelper.getCandidates()
        companys = MockHelper.getCompanys()
    }
    
    public func setCurrentUser(user: User?){
        self.currentUser = user
    }
    public func getCurrentUser() -> User?{
        return currentUser
    }
    public func getCurrentCandidate() -> Candidate?{
        let response = self.candidates.first(where: {$0.email == currentUser?.email})
        return response
    }
    public func getCurrentCompany() -> Company?{
        let response = self.companys.first(where: {$0.email == currentUser?.email})
        return response
    }
    
    public func getUser(email: String) -> User?{
        if let user = self.candidates.first(where: {$0.email == email}) {
            return user
        }
        return self.companys.first(where: {$0.email == email})
    }
    
    public func addUser(user: User){
        if (user.type == .PF){
            candidates.removeAll(where: {$0.email == user.email})
            self.candidates.append(user as! Candidate)
        } else {
            companys.removeAll(where: {$0.email == user.email})
            self.companys.append(user as! Company)
        }
    }
    
    static func loggoff(context: UIViewController){
        shared.setCurrentUser(user: nil)
        context.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Firebase create user
    public func createFirebaseUserLogin(user: User){
        var createdUser = user
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { authResult, error in
            if error != nil{
                return
            }else{
                if let uid = authResult?.user.uid {
                    createdUser.id = uid
                    user.type == .PF ? (self.createFirebaseCandidate(createdUser as! Candidate)) : (self.createFirebaseCompany(createdUser as! Company))
                }
            }
            
        }
    }
    
    public func createFirebaseCandidate(_ user: Candidate){
        do {
            try db.collection("candidate").document("\(user.id!)").setData(from: user)
        } catch let error {
            print("Deu ruim salvando user: \(error)")
        }
        
    }
    public func createFirebaseCompany(_ user: Company){
        do {
            try db.collection("company").document("\(user.id!)").setData(from: user)
        } catch let error {
            print("Deu ruim salvando user: \(error)")
        }
    }
}
