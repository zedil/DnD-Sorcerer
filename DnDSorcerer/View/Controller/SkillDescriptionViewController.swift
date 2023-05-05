//
//  SkillDescriptionViewController.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 1.05.2023.
//

import UIKit

class SkillDescriptionViewController: UIViewController {
    
    private let skillDescView = SkillDescriptionView()
    
    public var indexText: String = ""
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "titleLabel"
        label.textColor = UIColor(named: "appDarkest")
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "appSoftBrown")

        addSubViews()
        applyConstraints()
        configureContents()
        fetchData()
    }
    
    private func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(skillDescView)
    }
    
    private func applyConstraints() {
        
        let titleLabelConst = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        NSLayoutConstraint.activate(titleLabelConst)
        
        let skillDescConst = [
            skillDescView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 85),
            skillDescView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skillDescView.widthAnchor.constraint(equalToConstant: 350)
        ]
        NSLayoutConstraint.activate(skillDescConst)
    }
    
    private func configureContents() {
        skillDescView.translatesAutoresizingMaskIntoConstraints = false
        skillDescView.backgroundColor = UIColor(named: "appYellow")
        skillDescView.layer.cornerRadius = 20
        
        titleLabel.text = indexText
    }
    
    private func fetchData() {
        APICaller.shared.getSkill(with: indexText) { [weak self] result in
            switch result {
            case .success(let skill):
                DispatchQueue.main.async {
                    self?.skillDescView.descriptionLabel.text = skill[0].desc?[0]
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
