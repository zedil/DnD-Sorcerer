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
    
    private var titleDesc: UILabel = {
        let title = UILabel()
        title.text = "titleLabel"
        title.textColor = UIColor(named: "appDarkest")
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private var imageViewDesc: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "potion")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
        applyConstraint()
        configureContent()
        fetchData()
    }
    
    private func addSubViews() {
        view.addSubview(titleDesc)
        view.addSubview(imageViewDesc)
        view.addSubview(spellDesc)
        spellDesc.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func applyConstraint() {
        let titleConst = [
            titleDesc.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ]
        NSLayoutConstraint.activate(titleConst)
        
        let imageCons = [
            imageViewDesc.topAnchor.constraint(equalTo: titleDesc.bottomAnchor, constant: 20),
            imageViewDesc.centerXAnchor.constraint(equalTo: titleDesc.centerXAnchor),
            imageViewDesc.heightAnchor.constraint(equalToConstant: 100),
            imageViewDesc.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(imageCons)
        
        
        let spellDescCons = [
            spellDesc.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40),
            spellDesc.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            spellDesc.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            spellDesc.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height / 2))
        ]
        NSLayoutConstraint.activate(spellDescCons)
    }
    
    private func configureContent() {
        titleDesc.text = spellIndex.uppercased().replacingOccurrences(of: "-", with: " ")
        titleDesc.textAlignment = .center
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
