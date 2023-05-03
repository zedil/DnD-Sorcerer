//
//  SkillsTableViewCell.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 30.04.2023.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {
    
    static let identifier = "SkillsTableViewCell"
    
    public let skillLabel: UILabel = {
        let label = UILabel()
        label.text = "skillLabel"
        label.textColor = UIColor(named: "appDarkest")
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let skillImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "diamond")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let skillButton: UIButton = {
        let button = UIButton()
        button.setTitle("O", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addSubViews() {
        addSubview(skillImage)
        addSubview(skillLabel)
        addSubview(skillButton)
    }
    
    private func configureConstraint() {
        let skillImageConst = [
            skillImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            skillImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            skillImage.heightAnchor.constraint(equalToConstant: 40),
            skillImage.widthAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(skillImageConst)
        
        let skillLabelConst = [
            skillLabel.leadingAnchor.constraint(equalTo: skillImage.trailingAnchor, constant: 20),
            skillLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ]
        NSLayoutConstraint.activate(skillLabelConst)
        
        let skillButtonConst = [
            skillButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            skillButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            skillButton.widthAnchor.constraint(equalToConstant: 20),
            skillButton.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(skillButtonConst)
    }
    
    
}
