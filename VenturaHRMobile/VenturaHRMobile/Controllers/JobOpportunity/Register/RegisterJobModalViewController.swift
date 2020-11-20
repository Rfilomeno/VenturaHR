//
//  RegisterJobModalViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 20/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class RegisterJobModalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var skillNameField: UITextField!
    @IBOutlet weak var skillWeightLabel: UILabel!
    @IBOutlet weak var skillWeightSlider: UISlider!
    @IBOutlet weak var addSkillTableView: UITableView!
    @IBOutlet weak var addSkillButton: UIButton!
    private var skillList: [Skill] = []
    private let userRepository = UserRepository.shared
    private let jobRepository = JobOpportunityRepository.shared
    weak var delegate: ModalViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "JobDetailTableViewCell", bundle: nil)
        self.addSkillTableView.register(nib, forCellReuseIdentifier: "jobDetailCell")
        skillWeightSlider.isContinuous = false
        expirationDateLabel.text = "Expiração: \(DateHelper.getExpirationDate())"
    }

    @IBAction func skillWeightSliderAction(_ sender: UISlider) {
        sender.setValue(sender.value.rounded(), animated: true)
        skillWeightLabel.text = "\(Int(sender.value))"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 25
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return skillList.count
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobDetailCell", for: indexPath) as! JobDetailTableViewCell
        let skill = skillList[indexPath.row]
        cell.skillTitleLabel.text = skill.name
        cell.answerLabel.text = "Peso: \(skill.weight)"
          return cell
      }
    
    
    
    
    @IBAction func addSkillButtonAction(_ sender: Any) {
        let skill = Skill(name: skillNameField.text ?? "", weight: Int(skillWeightSlider.value.rounded()))
        skillList.append(skill)
        skillNameField.text = ""
        skillWeightSlider.setValue(1, animated: true)
        skillWeightLabel.text = "1"
        addSkillTableView.reloadData()
    }
    @IBAction func publishButtonAction(_ sender: Any) {
        guard let company = userRepository.getCurrentCompany() else {return}
        let job = JobOpportunity(company: company, title: titleField.text ?? "", description: descriptionField.text ?? "", skills: skillList)
        jobRepository.addJobOpportunity(job: job)
        delegate?.returnFromModal()
        self.dismiss(animated: true, completion: nil)
    }
    
    

}