//
//  ThrowSecondViewController.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 30.04.2023.
//

import UIKit

class ThrowSecondViewController: UIViewController {
    
    private var ability: [Ability] = [Ability]()
    private var skills: [Generic] = [Generic]()
    
    private let throwView = SaveThrowView()
    
    private let skillTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SkillsTableViewCell.self, forCellReuseIdentifier: SkillsTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let backButton: UIButton = {
       let button = UIButton()
        button.setTitle(" <- Back", for: .normal)
        button.setTitleColor(UIColor(named: "appDarkest"), for: .normal)
        button.backgroundColor = UIColor(named: "appSoftBrown")
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(throwView)
        view.addSubview(skillTableView)
        view.addSubview(backButton)
        skillTableView.delegate = self
        skillTableView.dataSource = self
        
        throwView.translatesAutoresizingMaskIntoConstraints = false
        throwView.backgroundColor = .lightGray
        
        applyConstraint()
        fetchData()
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
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
        
        let backButtonConst = [
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(backButtonConst)
    }
    
    private func fetchData() {
        APICaller.shared.getAbility(with: Abilities.con.rawValue) { [weak self] result in
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
    
    @objc func backButtonTapped() {
        print("xcvxcvxv")
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension ThrowSecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.identifier, for: indexPath) as? SkillsTableViewCell else {
            return UITableViewCell()
        }
        cell.skillLabel.text = skills[indexPath.row].name
        
        return cell
    }
}
