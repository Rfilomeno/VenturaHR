//
//  MyJobOpportunityViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 18/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class MyJobOpportunityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New"
        // Do any additional setup after loading the view.
    }

    @IBAction func loggoffButtonAction(_ sender: Any) {
        let repository = UserRepository.shared
        repository.setCurrentUser(user: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
}
