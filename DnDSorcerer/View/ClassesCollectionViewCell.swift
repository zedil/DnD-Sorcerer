//
//  ClassesCollectionViewCell.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 30.04.2023.
//

import UIKit

class ClassesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ClassesCollectionViewCell"
    
    public let classImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ring")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public let classLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "classLabel"
        label.textColor = UIColor(named: "appDarkest")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        applyConstraints()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addSubViews() {
        contentView.addSubview(classImage)
        contentView.addSubview(classLabel)
    }
    
    private func applyConstraints() {
        
        let classImageConst = [
            classImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            classImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            classImage.widthAnchor.constraint(equalToConstant: 50),
            classImage.heightAnchor.constraint(equalToConstant: 50)
            
        ]
        NSLayoutConstraint.activate(classImageConst)
        
        let classLabelConst = [
            classLabel.topAnchor.constraint(equalTo: classImage.bottomAnchor, constant: 10),
            classLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(classLabelConst)
        
    }
    
    private func configureContents() {
        contentView.backgroundColor = UIColor(named: "appSoftBrown")
        contentView.layer.cornerRadius = 6
    }
}
