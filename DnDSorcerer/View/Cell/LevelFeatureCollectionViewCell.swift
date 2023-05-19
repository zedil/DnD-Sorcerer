//
//  LevelFeatureCollectionViewCell.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 10.05.2023.
//

import UIKit

class LevelFeatureCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LevelFeatureCollectionViewCell"
    
    public let levelImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ring")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public let levelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "levelLabel"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    private func addSubViews() {
        addGradientLayer()
        addSubview(levelImage)
        addSubview(levelLabel)
    }
    
    private func addGradientLayer() {
        layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.black.cgColor, UIColor(named: "appLightGray")?.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.cornerRadius = 75
    }
    
    private func applyConstraints() {
        
        let levelImageConst = [
            levelImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            levelImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            levelImage.widthAnchor.constraint(equalToConstant: 50),
            levelImage.heightAnchor.constraint(equalToConstant: 50)
            
        ]
        NSLayoutConstraint.activate(levelImageConst)
        
        let levelLabelConst = [
            levelLabel.topAnchor.constraint(equalTo: levelImage.bottomAnchor, constant: 10),
            levelLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            levelLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            levelLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(levelLabelConst)
        
    }
    
}
