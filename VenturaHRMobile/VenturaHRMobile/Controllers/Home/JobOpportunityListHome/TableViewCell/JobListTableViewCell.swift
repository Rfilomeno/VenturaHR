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
    //@IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var answeredLabel: UILabel!
    public var cameFromCompanyHome = false
    var repository = UserRepository.shared

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell(job: JobOpportunity){
        let company = repository.getUser(email: job.companyEmail!)
        titleLabel.text = job.title
        companyLabel.text = company?.name
        //expirationDateLabel.text = job.expirationDate
        let repository = UserRepository.shared
        if let user = repository.getCurrentUser(){
            answeredLabel.isHidden = checkNotAnswered(job: job, user: user)
        }
        if cameFromCompanyHome{
            answeredLabel.isHidden = false
            let answeredNumber = job.answers!.count
            answeredLabel.text = String(answeredNumber) + (answeredNumber == 1 ? " resposta" : " respostas")
        }
        
    }
    
    private func checkNotAnswered(job: JobOpportunity, user: User) -> Bool{
        guard let answers = job.answers else {return true}
        return !(answers.contains(where: {$0.candidateEmail == user.email}))
    }
    
}
