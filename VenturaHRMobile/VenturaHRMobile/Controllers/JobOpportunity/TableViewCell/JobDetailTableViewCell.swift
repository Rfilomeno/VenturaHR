//
//  JobDetailTableViewCell.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 19/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit



class JobDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var skillTitleLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell(skill: Skill){
        self.skillTitleLabel.text = skill.name
        self.answerLabel.isHidden = true
    }
    public func setupApplyedCell(skill: Skill){
        self.skillTitleLabel.text = skill.name
        let skillDescription = ["Sem Conhecimento", "Júnior", "Pleno", "Senior", "Mestre Jedi"]
        self.answerLabel.text = skillDescription[Int(skill.candidateAnswer-1)]
        self.answerLabel.isHidden = false
    }
   
}
