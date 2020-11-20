//
//  CandidateHomeViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 19/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class CandidateHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var candidateNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cpfLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var cadidateJobApplysTableView: UITableView!
    let userRepository = UserRepository.shared
    let jobRepository = JobOpportunityRepository.shared
    var candidate: Candidate?
    var candidateJobsApplys: [JobOpportunity]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.candidate = userRepository.getCurrentCandidate()
        let nib = UINib.init(nibName: "JobListTableViewCell", bundle: nil)
        self.cadidateJobApplysTableView.register(nib, forCellReuseIdentifier: "jobCell")
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupView()
    }
    
    private func setupView(){
        self.candidateJobsApplys = jobRepository.getJobList(from: candidate!)
        candidateNameLabel.text = candidate?.name
        emailLabel.text = candidate?.email
        phoneLabel.text = candidate?.phone
        cpfLabel.text = candidate?.cpf
        adressLabel.text = candidate?.address
        cadidateJobApplysTableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return candidateJobsApplys?.count ?? 0
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobListTableViewCell
          guard let job = candidateJobsApplys?[indexPath.row] else { return cell}
          cell.setupCell(job: job)
          return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let job = candidateJobsApplys?[indexPath.row] else { return }
        let controller = JobOpportunityDetailsViewController(nibName: "JobOpportunityDetailsViewController", bundle: nil)
        controller.job = job
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        let modalViewController = RegisterViewController()
        modalViewController.delegate = self
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.isCompany = false
        modalViewController.editMode = true
        present(modalViewController, animated: true, completion: nil)
    }
    
    @IBAction func loggoffButtonAction(_ sender: Any) {
        UserRepository.loggoff(context: self)
    }

}

extension CandidateHomeViewController: ModalViewControllerProtocol {
    func returnFromModal(){
        candidate = userRepository.getCurrentCandidate()
        self.setupView()
    }
}
