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

public protocol repositoryProtocol: NSObjectProtocol{
    func returnFromRepository(resposta: Bool)
}
extension repositoryProtocol{
    func returnFromRepository(resposta: Bool) {}
}

public class UserRepository {
    private var candidates: [Candidate]
    private var companys: [Company]
    private var currentUser: User?
    public var delegate: repositoryProtocol?
    private var db = Firestore.firestore()
    static var shared: UserRepository = {
        let instance = UserRepository()
        return instance
    }()
    
    private init(){
        
        candidates = []
        companys = []
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
            let candidate = db.collection("candidate").document("\(user.id!)")
            do{
             try candidate.setData(from: user as! Candidate)
            }catch let error{
                print(error)
            }

        } else {
            let company = db.collection("company").document("\(user.id!)")
            do{
             try company.setData(from: user as! Company)
            }catch let error{
                print(error)
            }

        }
    }
    
    static func loggoff(context: UIViewController){
        shared.setCurrentUser(user: nil)
        do {
            try Auth.auth().signOut()
        } catch {
            print("Deu ruim ao deslogar")
        }
        context.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Firebase create user
    public func createFirebaseUserLogin(user: User){
        var createdUser = user
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { authResult, error in
            sleep(1)
            if error != nil{
                self.delegate?.returnFromRepository(resposta: false)
            }else{
                self.delegate?.returnFromRepository(resposta: true)
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
    
    public func fetchUserData(){
        db.collection("candidate").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
            self.candidates = documents.compactMap { queryDocumentSnapshot -> Candidate? in
            return try? queryDocumentSnapshot.data(as: Candidate.self)
            }
        }
        
        db.collection("company").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
            self.companys = documents.compactMap { queryDocumentSnapshot -> Company? in
            return try? queryDocumentSnapshot.data(as: Company.self)
            }
        }
        
    }
}
