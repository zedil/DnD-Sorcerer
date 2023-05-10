//
//  TextValueView.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 10.05.2023.
//

import Foundation
import UIKit

class TextValueView: UIView {
    
    public let textTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "textTitle"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    public let textValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "textValue"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    public var titleLabel: String? {
        willSet {
            textTitle.text = newValue
        }
    }
    
    public var valueLabel: String? {
        willSet {
            textValue.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addSubViews() {
        addSubview(textTitle)
        addSubview(textValue)
    }
    
    private func applyConstraints() {
        
        let textTitleConst = [
            textTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            textTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            textTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(textTitleConst)
        
        let textValueConst = [
            textValue.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            textValue.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            textValue.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textValue.leadingAnchor.constraint(equalTo: textTitle.trailingAnchor, constant: 15),
        ]
        NSLayoutConstraint.activate(textValueConst)
        
        
        self.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
}
