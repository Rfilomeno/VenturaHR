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
    private let userRepository = UserRepository.shared
    var job: JobOpportunity?
    private var skillList: [Skill]?
    private var candidateHasApplied = false
    public var cameFromCompany = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = userRepository.getCurrentUser()
        let nib = UINib.init(nibName: "JobDetailTableViewCell", bundle: nil)
        self.skillsTableView.register(nib, forCellReuseIdentifier: "jobDetailCell")
        self.skillList = job?.skills
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let jobRepository = JobOpportunityRepository.shared
        if let candidateSkills = jobRepository.getCandidateAnswer(for: job!){
            self.skillList = candidateSkills.skills
            candidateHasApplied = true
        }
        setupView()
    }
    
    private func setupView(){
        let company = userRepository.getUser(email: job?.companyEmail ?? "")
        self.applyButton.isHidden = (user?.type == .PJ ? true : false)
        self.titleLabel.text = job?.title
        self.companyLabel.text = company?.name
        self.publishDateLabel.text = job?.publicationDate
        self.expirationDateLabel.text = job?.expirationDate
        self.descripitionLabel.text = job?.description
        self.expiredLabel.isHidden = (job?.stillValid ?? true)
        if !(user?.type == .PF ? true : false) && !cameFromCompany{
            self.applyButton.backgroundColor = .lightGray
            self.applyButton.setTitle("Realizar Login", for: .normal)
        }
        if candidateHasApplied && !cameFromCompany{
            self.applyButton.backgroundColor = .systemGreen
            self.applyButton.setTitle("Vaga já Respondida", for: .normal)
            self.applyButton.isEnabled = false
        }
        if cameFromCompany {
            self.applyButton.setTitle("Rank de candidatos", for: .normal)
            self.applyButton.isHidden = false
            if job?.answers?.isEmpty ?? true {
                self.applyButton.isEnabled = false
                self.applyButton.backgroundColor = .lightGray
            }
        }
        skillsTableView.reloadData()
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
        if candidateHasApplied {
            cell.setupApplyedCell(skill: skill)
        } else{
            cell.setupCell(skill: skill)
        }
        if cameFromCompany {
            cell.answerLabel.text = "min: \(skill.PMD!) peso: \(skill.weight!)"
            cell.answerLabel.isHidden = false
            cell.answerLabel.textColor = .black
        }
          return cell
      }

    @IBAction func applyButonAction(_ sender: Any) {
        if !(user?.type == .PF ? true : false) && !cameFromCompany{
            navigationController?.popToRootViewController(animated: true)
        } else if cameFromCompany {
            let modalViewController = CandidateRangingViewController()
            modalViewController.modalPresentationStyle = .formSheet
            modalViewController.job = job
            present(modalViewController, animated: true, completion: nil)
        } else {
            let modalViewController = AnswerModalViewController()
            modalViewController.delegate = self
            modalViewController.modalPresentationStyle = .formSheet
            modalViewController.job = job
            present(modalViewController, animated: true, completion: nil)
        }
    }
}

extension JobOpportunityDetailsViewController:ModalViewControllerProtocol{
    func returnFromModal() {
        let jobRepository = JobOpportunityRepository.shared
        if let candidateSkills = jobRepository.getCandidateAnswer(for: job!){
            self.skillList = candidateSkills.skills
            candidateHasApplied = true
        }
        setupView()
    }
}
