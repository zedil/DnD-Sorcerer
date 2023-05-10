//
//  LevelView.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 10.05.2023.
//

import Foundation
import UIKit

class LevelView: UIView {
    
    public let levelTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "appLightGray")
        return view
    }()
    
    public let levelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "levelll"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    public let classSpecificView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "appLightGray")
        return view
    }()
    
    public let specificLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "specificLabel"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    public let nextButton: UIButton = {
        let button = UIButton()
         button.setTitle("Next ->", for: .normal)
         button.setTitleColor(UIColor(named: "appDarkest"), for: .normal)
         button.backgroundColor = UIColor(named: "appSoftBrown")
         button.layer.cornerRadius = 15
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()
    
    public let classSpecificStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 1
        stack.distribution = .equalCentering
        stack.backgroundColor = .cyan
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public var pointLabel = TextValueView()
    public var metamagicLabel = TextValueView()
    public var scoreLabel = TextValueView()
    public var profBonusesLabel = TextValueView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        applyConstraints()
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addSubViews() {
        addSubview(levelTitleView)
        levelTitleView.addSubview(levelTitle)
        
        addSubview(classSpecificStackView)
        classSpecificStackView.addArrangedSubview(pointLabel)
        classSpecificStackView.addArrangedSubview(metamagicLabel)
        classSpecificStackView.addArrangedSubview(scoreLabel)
        classSpecificStackView.addArrangedSubview(profBonusesLabel)
    }
    
    private func applyConstraints() {
        
        let levelTitleViewConst = [
            levelTitleView.topAnchor.constraint(equalTo: self.topAnchor, constant: -25),
            levelTitleView.widthAnchor.constraint(equalToConstant: 120),
            levelTitleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            levelTitleView.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(levelTitleViewConst)
        
        let levelTitleConst = [
            levelTitle.centerXAnchor.constraint(equalTo: levelTitleView.centerXAnchor),
            levelTitle.centerYAnchor.constraint(equalTo: levelTitleView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(levelTitleConst)
        
        let classSpecificStackViewConst = [
            classSpecificStackView.topAnchor.constraint(equalTo: levelTitleView.bottomAnchor, constant: 20),
            classSpecificStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            classSpecificStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            classSpecificStackView.centerXAnchor.constraint(equalTo: self.levelTitleView.centerXAnchor),
            classSpecificStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(classSpecificStackViewConst)
        
    }
    
    private func configureContent() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
    }
    
    
}
