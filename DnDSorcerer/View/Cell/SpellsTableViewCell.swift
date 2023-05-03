//
//  SpellsTableViewCell.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 3.05.2023.
//

import UIKit

class SpellsTableViewCell: UITableViewCell {

    static let identifier = "SpellsTableViewCell"
    
    private let spellImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "potion")
        return image
    }()
    
    public let spellLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor(named: "appDarkest")
        name.font = UIFont.boldSystemFont(ofSize: 15)
        return name
    }()
    
    private let nextLabel: UILabel = {
        let next = UILabel()
        next.translatesAutoresizingMaskIntoConstraints = false
        next.textColor = UIColor(named: "appDarkest")
        next.font = UIFont.boldSystemFont(ofSize: 15)
        return next
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
        addSubview(spellImageView)
        addSubview(spellLabel)
        addSubview(nextLabel)
        

    }
    
    private func configureConstraint() {
        let spellImageConst = [
            spellImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            spellImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spellImageView.heightAnchor.constraint(equalToConstant: 40),
            spellImageView.widthAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(spellImageConst)
        
        let spellLabelConst = [
            spellLabel.leadingAnchor.constraint(equalTo: spellImageView.trailingAnchor, constant: 20),
            spellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ]
        NSLayoutConstraint.activate(spellLabelConst)
        
        let NextLabelConst = [
            nextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nextLabel.widthAnchor.constraint(equalToConstant: 20),
            nextLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(NextLabelConst)

    }
    
}
