//
//  SkillDescriptionView.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 1.05.2023.
//

import UIKit

class SkillDescriptionView: UIView {
    
    private let imageContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 75
        view.backgroundColor = UIColor(named: "appYellow")
        view.layer.borderColor = UIColor(named: "appSoftBrown")?.cgColor
        view.layer.borderWidth = 15
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "note")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    public let descriptionLabel: UILabel = {
        let desc = UILabel()
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.text = "description"
        desc.textAlignment = .center
        desc.font = UIFont.boldSystemFont(ofSize: 17)
        desc.numberOfLines = 0
        return desc
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
        addSubview(imageContent)
        imageContent.addSubview(imageView)
        addSubview(descriptionLabel)
    }
    
    private func applyConstraints() {
        
        let imageContentConst = [
            imageContent.topAnchor.constraint(equalTo: self.topAnchor, constant: -50),
            imageContent.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageContent.heightAnchor.constraint(equalToConstant: 150),
            imageContent.widthAnchor.constraint(equalToConstant: 150)
        ]
        NSLayoutConstraint.activate(imageContentConst)
        
        let imageViewConst = [
            imageView.centerXAnchor.constraint(equalTo: imageContent.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageContent.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        NSLayoutConstraint.activate(imageViewConst)
        
        let descLabelConst = [
            descriptionLabel.topAnchor.constraint(equalTo: imageContent.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(descLabelConst)
        
        self.heightAnchor.constraint(equalToConstant: 450).isActive = true
    }
    
}
