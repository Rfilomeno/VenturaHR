//
//  CompanyHomeViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 20/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class CompanyHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cnpjLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var companyJobsPublishedTableView: UITableView!
    let userRepository = UserRepository.shared
    let jobRepository = JobOpportunityRepository.shared
    var company: Company?
    var companyJobsPublished: [JobOpportunity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.company = userRepository.getCurrentCompany()
        let nib = UINib.init(nibName: "JobListTableViewCell", bundle: nil)
        self.companyJobsPublishedTableView.register(nib, forCellReuseIdentifier: "jobCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }

    private func setupView(){
        self.companyJobsPublished = jobRepository.getJobList(by: company!)
        companyNameLabel.text = company?.name
        contactNameLabel.text = company?.contactName
        emailLabel.text = company?.email
        phoneLabel.text = company?.phone
        cnpjLabel.text = company?.cnpj
        adressLabel.text = company?.address
        companyJobsPublishedTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return companyJobsPublished?.count ?? 0
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobListTableViewCell
        guard let job = companyJobsPublished?[indexPath.row] else { return cell}
        cell.cameFromCompanyHome = true
        cell.setupCell(job: job)
        return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let job = companyJobsPublished?[indexPath.row] else { return }
        let controller = JobOpportunityDetailsViewController(nibName: "JobOpportunityDetailsViewController", bundle: nil)
        controller.job = job
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    @IBAction func publishNewJob(_ sender: Any) {
        let modalViewController = RegisterJobModalViewController()
        modalViewController.delegate = self
        modalViewController.modalPresentationStyle = .formSheet
        present(modalViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func editButtonAction(_ sender: Any) {
        let modalViewController = RegisterViewController()
        modalViewController.delegate = self
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.isCompany = true
        modalViewController.editMode = true
        present(modalViewController, animated: true, completion: nil)
    }
    
    @IBAction func loggoffButtonAction(_ sender: Any) {
        UserRepository.loggoff(context: self)
    }
    
}

extension CompanyHomeViewController: ModalViewControllerProtocol {
    func returnFromModal(){
        company = userRepository.getCurrentCompany()
        self.setupView()
    }
}

