//
//  JobOpportunityListViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 18/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class JobOpportunityListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var jobOpportunityTableView: UITableView!
    private var jobList: [JobOpportunity]?
    private var avalibleJobList: [JobOpportunity]?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Oportunidades abertas"
        self.jobOpportunityTableView.delegate = self
        let repository = JobOpportunityRepository.shared
        self.jobList = repository.getJobList()
        let nib = UINib.init(nibName: "JobListTableViewCell", bundle: nil)
        self.jobOpportunityTableView.register(nib, forCellReuseIdentifier: "jobCell")
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let unwrapedJobList = self.jobList else { return 0 }
        self.avalibleJobList = unwrapedJobList.filter({$0.stillValid})
        return avalibleJobList?.count ?? 0
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 60 : 100
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobListTableViewCell
        guard let job = avalibleJobList?[indexPath.row] else { return cell}
        cell.setupCell(job: job)
        return cell
    }

        
}
