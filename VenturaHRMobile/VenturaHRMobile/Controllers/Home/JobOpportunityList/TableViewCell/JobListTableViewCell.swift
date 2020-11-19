//
//  jobListTableViewCell.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 19/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class JobListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var answeredLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell(job: JobOpportunity){
        titleLabel.text = job.title
        companyLabel.text = job.company.name
        expirationDateLabel.text = job.expirationDate
        let repository = UserRepository.shared
        if let user = repository.getCurrentUser(){
            answeredLabel.isHidden = checkAnswered(job: job, user: user)
        }
        
    }
    
    private func checkAnswered(job: JobOpportunity, user: User) -> Bool{
        let answers = job.answers
        return !(answers.contains(where: {$0.candidate.email == user.email}))
    }
    
}
