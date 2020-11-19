//
//  AnswerModalViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 19/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit
import DropDown

class AnswerModalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var answerSkillsTableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    var skillList: [Skill]!
    var job: JobOpportunity?
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "AnswerTableViewCell", bundle: nil)
        self.answerSkillsTableView.register(nib, forCellReuseIdentifier: "answerSkillCell")
        self.skillList = job?.skills ?? []
        setupView()
    }

    private func setupView(){
        self.jobTitleLabel.text = job?.title
        self.companyNameLabel.text = job?.company.name
        self.skillList = job?.skills
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 35
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return skillList?.count ?? 0
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "answerSkillCell", for: indexPath) as! AnswerTableViewCell
          guard let skill = skillList?[indexPath.row] else { return cell}
        cell.titleLabel.text = skill.name
          return cell
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell: AnswerTableViewCell = tableView.cellForRow(at: indexPath) as! AnswerTableViewCell {
            dropDown.dataSource = ["Sem Conhecimento", "Júnior", "Pleno", "Senior", "Mestre Jedi"]
            dropDown.anchorView = cell
            dropDown.bottomOffset = CGPoint(x: 0, y: cell.frame.size.height)
            dropDown.backgroundColor = .white
            dropDown.show()
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
              guard let _ = self else { return }
                cell.skillValueLabel.text = item
                self?.skillList[indexPath.row].candidateAnswer = index
            }
          } 
    }
    
    @IBAction func applyButtonAction(_ sender: Any) {
        let userRepository = UserRepository.shared
        let jobRepository = JobOpportunityRepository.shared
        if let candidate = userRepository.getCurrentCandidate(){
         let answer = Answer(candidate: candidate, skills: skillList)
         jobRepository.addAnswerTo(job: job!, answer: answer)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
