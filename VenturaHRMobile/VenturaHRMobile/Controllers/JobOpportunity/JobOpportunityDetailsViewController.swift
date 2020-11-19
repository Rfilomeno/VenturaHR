//
//  JobOpportunityDetailsViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 19/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class JobOpportunityDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var descripitionLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var expiredLabel: UILabel!
    
    @IBOutlet weak var skillsTableView: UITableView!
    
    private var user: User?
    private var userRepository = UserRepository.shared
    var job: JobOpportunity?
    private var skillList: [Skill]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = userRepository.getCurrentUser()
        let nib = UINib.init(nibName: "JobDetailTableViewCell", bundle: nil)
        self.skillsTableView.register(nib, forCellReuseIdentifier: "jobDetailCell")
        self.skillList = job?.skills
        setupView()
    }
    
    private func setupView(){
        self.applyButton.isHidden = (user?.type == .PJ ? true : false)
        self.titleLabel.text = job?.title
        self.companyLabel.text = job?.company.name
        self.publishDateLabel.text = job?.publicationDate
        self.expirationDateLabel.text = job?.expirationDate
        self.descripitionLabel.text = job?.description
        self.expiredLabel.isHidden = (job?.stillValid ?? true)
        if !(user?.type == .PF ? true : false){
            self.applyButton.backgroundColor = .lightGray
            self.applyButton.setTitle("Realizar Login", for: .normal)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 25
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return skillList?.count ?? 0
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "jobDetailCell", for: indexPath) as! JobDetailTableViewCell
          guard let skill = skillList?[indexPath.row] else { return cell}
          cell.setupCell(skill: skill)
          return cell
      }

    @IBAction func applyButonAction(_ sender: Any) {
        if !(user?.type == .PF ? true : false){
            navigationController?.popToRootViewController(animated: true)
        } else {
            let modalViewController = AnswerModalViewController()
            modalViewController.modalPresentationStyle = .formSheet
            modalViewController.job = job
            present(modalViewController, animated: true, completion: nil)
        }
    }
}
