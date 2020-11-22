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
    @IBOutlet weak var pmdLabel: UILabel!
    @IBOutlet weak var pmdSlider: UISlider!
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
    @IBAction func pmdSliderAction(_ sender: UISlider) {
        sender.setValue(sender.value.rounded(), animated: true)
        pmdLabel.text = "\(Int(sender.value))"
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            skillList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    
    
    @IBAction func addSkillButtonAction(_ sender: Any) {
        let skill = Skill(name: skillNameField.text ?? "", weight: Double(Int(skillWeightSlider.value.rounded())), pmd: Double(Int(pmdSlider.value.rounded())))
        skillList.append(skill)
        skillNameField.text = ""
        skillWeightSlider.setValue(1, animated: true)
        skillWeightLabel.text = "1"
        pmdSlider.setValue(1, animated: true)
        pmdLabel.text = "1"
        addSkillTableView.reloadData()
    }
    @IBAction func publishButtonAction(_ sender: Any) {
        if validateFields(){
            guard let company = userRepository.getCurrentCompany() else {return}
            let job = JobOpportunity(companyEmail: company.email, title: titleField.text ?? "", description: descriptionField.text ?? "", skills: skillList)
            jobRepository.addJobOpportunity(job: job)
            delegate?.returnFromModal()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    

}

extension RegisterJobModalViewController: validateProtocol{
    func validateFields() -> Bool {
        var validator = true
        if titleField.text?.isEmpty ?? true {
            titleField.layer.borderWidth = 1
            titleField.layer.borderColor = UIColor.red.cgColor
            validator = false
        } else {
            titleField.layer.borderWidth = 0
        }
        if descriptionField.text?.isEmpty ?? true {
            descriptionField.layer.borderWidth = 1
            descriptionField.layer.borderColor = UIColor.red.cgColor
            validator = false
        } else {
            descriptionField.layer.borderWidth = 0
        }
        if skillList.isEmpty {
            skillNameField.layer.borderWidth = 1
            skillNameField.layer.borderColor = UIColor.red.cgColor
        }else {
            skillNameField.layer.borderWidth = 0
        }
        return validator
    }
}
