//
//  CandidateRangingViewController.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 20/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class CandidateRangingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var candidateView: UIView!
    @IBOutlet weak var cadidateNameLabel: UILabel!
    @IBOutlet weak var candidateEmailLabel: UILabel!
    @IBOutlet weak var candidatePhoneLabel: UILabel!
    @IBOutlet weak var candidateCpfLabel: UILabel!
    @IBOutlet weak var candidateAdressLabel: UILabel!
    @IBOutlet weak var pmdLabel: UILabel!
    
    public var job: JobOpportunity!
    var answers: [Answer]?
    var selectedAnswer: Answer?
    
    
    
    @IBOutlet weak var rankingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answers = job.answers
        self.pmdLabel.text = String(format: "%.2f", job.answers[0].minScore)
        answers = answers?.sorted {$0.candidateScore > $1.candidateScore}
        let nib = UINib.init(nibName: "AnswerTableViewCell", bundle: nil)
        self.rankingTableView.register(nib, forCellReuseIdentifier: "answerSkillCell")
        setupView()
    }

    func setupView(){
        candidateView.layer.borderWidth = 2
        candidateView.layer.borderColor = UIColor.lightGray.cgColor
        candidateView.layer.cornerRadius = 15
        candidateView.isHidden = true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 35
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return answers?.count ?? 0
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "answerSkillCell", for: indexPath) as! AnswerTableViewCell
          guard let answer = answers?[indexPath.row] else { return cell}
        cell.titleLabel.text = "\(indexPath.row + 1)º - \(answer.candidate.name)"
        cell.skillValueLabel.text = "Score: \(String(format: "%.2f", answer.candidateScore))"
        if !answer.gotMinScore{
            cell.skillValueLabel.textColor = .red
        }
          return cell
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAnswer = answers?[indexPath.row]
        guard let candidate = answers?[indexPath.row].candidate else { return }
        self.cadidateNameLabel.text = candidate.name
        self.candidateCpfLabel.text = candidate.cpf
        self.candidateEmailLabel.text = candidate.email
        self.candidatePhoneLabel.text = candidate.phone
        self.candidateAdressLabel.text = candidate.address
        self.candidateView.isHidden = false
    }
    
    @IBAction func answersButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Respostas do Candidato", message: nil, preferredStyle: .actionSheet)
        guard let candidateSkills = self.selectedAnswer?.skills else {return}
        for skill in candidateSkills {
            var gotRequiriment: UIAlertAction.Style = .default
            var symbol = "✅"
            if !skill.haveMandatory{
                gotRequiriment = .destructive
                symbol = "🚫"
            }
            alert.addAction(UIAlertAction(title: "\(skill.name) - \(skill.textAnswer) - \(symbol)", style: gotRequiriment, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
