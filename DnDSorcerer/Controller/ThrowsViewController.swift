//
//  ThrowsViewController.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import UIKit

class ThrowsViewController: UIViewController {
    
    private var ability: [Ability] = [Ability]()
    private var skills: [Generic] = [Generic]()
    
    private let throwView = SaveThrowView()
    
    private let skillTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SkillsTableViewCell.self, forCellReuseIdentifier: SkillsTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let nextButton: UIButton = {
       let button = UIButton()
        button.setTitle("Next ->", for: .normal)
        button.setTitleColor(UIColor(named: "appDarkest"), for: .normal)
        button.backgroundColor = UIColor(named: "appSoftBrown")
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        view.addSubview(throwView)
        view.addSubview(skillTableView)
        view.addSubview(nextButton)
        skillTableView.delegate = self
        skillTableView.dataSource = self
        
        throwView.translatesAutoresizingMaskIntoConstraints = false
        throwView.backgroundColor = .lightGray
        
        applyConstraint()
        fetchData()
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func configureNavigationBar() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ring")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        navigationItem.title = "Sorcerer Saving Throws"
        navigationController?.navigationBar.tintColor = .systemPink
    }
    
    private func applyConstraint() {
        
        let throwViewConst = [
            throwView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            throwView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            throwView.widthAnchor.constraint(equalToConstant: 450)
        ]
        NSLayoutConstraint.activate(throwViewConst)
        
        let tableViewConst = [
            skillTableView.topAnchor.constraint(equalTo: throwView.bottomAnchor, constant: 5),
            skillTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            skillTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            skillTableView.heightAnchor.constraint(equalToConstant: 350)
        ]
        NSLayoutConstraint.activate(tableViewConst)
        
        let nextButtonConst = [
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(nextButtonConst)
    }
    
    @objc func nextButtonTapped() {
        let vc = ThrowSecondViewController()
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: false)
    }
    
    private func fetchData() {
        APICaller.shared.getAbility(with: Abilities.cha.rawValue) { [weak self] result in
            switch result {
            case .success(let ability):
                self?.ability = ability
                self?.skills = ability[0].skills ?? [Generic]()
                 DispatchQueue.main.async {
                     self?.configureContent()
                     self?.skillTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureContent() {
        throwView.nameLabel.text = ability[0].full_name
        throwView.descLabel.text = (ability[0].desc?[0] ?? "") + "\n" + (ability[0].desc?[1] ?? "")
    }
}

enum Abilities: String {
    case con = "con"
    case cha = "cha"
}

extension ThrowsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexText = skills[indexPath.row].index
        let vc = SkillDescriptionViewController()
        vc.indexText = indexText
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.identifier, for: indexPath) as? SkillsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.skillLabel.text = skills[indexPath.row].name
        
        return cell
    }
}
