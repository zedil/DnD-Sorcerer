//
//  ProficiencyView.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 30.04.2023.
//

import UIKit

class ProficiencyView: UIView {
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "nameLabel"
        label.textColor = UIColor(named: "appDarkest")
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "typeLabel"
        label.textColor = UIColor(named: "appDarkest")
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let classesLabel: UILabel = {
        let label = UILabel()
        label.text = "classesLabel"
        label.textColor = UIColor(named: "appDarkest")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: "ring")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
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
        addSubview(typeLabel)
        addSubview(imageView)
    }
    
    private func applyConstraints() {
        let nameLabelConst = [
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 35),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
        ]
        NSLayoutConstraint.activate(nameLabelConst)
        
        let typeLabelConst = [
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            typeLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
        ]
        NSLayoutConstraint.activate(typeLabelConst)
        
        let imageViewConst = [
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(imageViewConst)
        
        //view'a height vermediğimiz zaman background görünmüyor.. shocked
        self.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }

}
