//
//  SpellDescriptionView.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 3.05.2023.
//

import UIKit

class SpellDescriptionView: UIView {
    
    public let descLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        addSubview(descLabel)
    }
    
    private func applyConstraints() {
        let descLabelConst = [
            descLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 45),
            descLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(descLabelConst)
    }
    
    private func configureContent() {
        self.backgroundColor = UIColor(named: "appSoftBrown")
        self.layer.cornerRadius = 50
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

}
