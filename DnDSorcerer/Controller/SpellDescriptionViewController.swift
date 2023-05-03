//
//  SpellDescriptionViewController.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 3.05.2023.
//

import UIKit

class SpellDescriptionViewController: UIViewController {
    
    public var spellIndex: String = ""
    
    private var spellDescArray = [String]()
    private var spellCount: Int?
    
    private let spellDesc = SpellDescriptionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addSubViews()
        applyConstraint()
        fetchData()
    }
    
    private func addSubViews() {
        view.addSubview(spellDesc)
        spellDesc.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func applyConstraint() {
        let spellDescCons = [
            spellDesc.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30),
            spellDesc.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            spellDesc.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            spellDesc.heightAnchor.constraint(equalToConstant: 450)
        ]
        NSLayoutConstraint.activate(spellDescCons)
    }
    
    private func fetchData() {
        APICaller.shared.getSkillDesc(with: spellIndex) { [weak self] result in
            switch result {
            case .success(let spell):
                DispatchQueue.main.async {
                    self?.spellCount = spell[0].desc?.count
                    for i in 0...(self?.spellCount ?? 1) - 1 {
                        let desc = spell[0].desc?[i]
                        self?.spellDescArray.append(desc ?? "")
                    }
                    let joinedDesc = self?.spellDescArray.joined(separator: ", ")
                    self?.spellDesc.descLabel.text = joinedDesc
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
