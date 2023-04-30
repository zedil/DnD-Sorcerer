//
//  ProficiensiesCollectionViewCell.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import UIKit

class ProficiensiesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProficiensiesCollectionViewCell"
    
    public let proficiencyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "pro"
        label.textColor = UIColor(named: "appDarkest")
        return label
    }()
    
    private let proficiencyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "spell")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureContents()
    }
    
    private func addSubViews() {
        contentView.addSubview(proficiencyName)
        contentView.addSubview(proficiencyImage)
    }
    
    private func configureContents() {
        contentView.backgroundColor = UIColor(named: "appSoftBrown")
        contentView.layer.cornerRadius = 6
    }
    
    private func applyConstraints() {
        let proficiencyNameConst = [
            proficiencyName.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30),
            proficiencyName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ]
        NSLayoutConstraint.activate(proficiencyNameConst)
        
        let proficiencyImageConst = [
            proficiencyImage.topAnchor.constraint(equalTo: proficiencyName.bottomAnchor, constant: 20),
            proficiencyImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            proficiencyImage.widthAnchor.constraint(equalToConstant: 50),
            proficiencyImage.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(proficiencyImageConst)
    }
}
