//
//  SaveThrowView.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 30.04.2023.
//

import Foundation
import UIKit

class SaveThrowView: UIView {
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "nameLabel"
        label.textColor = UIColor(named: "appDarkest")
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let descLabel: UILabel = {
        let label = UILabel()
        label.text = "descLabel"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "appDarkest")
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addSubViews() {
        addSubview(nameLabel)
        addSubview(descLabel)
    }
    
    private func applyConstraints() {
        let nameLabelConst = [
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35)
        ]
        NSLayoutConstraint.activate(nameLabelConst)
        
        let descLabelConst = [
            descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(descLabelConst)
        
        self.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        /*
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] */
    }
    
}
