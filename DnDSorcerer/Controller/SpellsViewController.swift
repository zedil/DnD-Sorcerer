//
//  SpellsViewController.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import UIKit

class SpellsViewController: UIViewController {
    
    private var spells: [Generic] = [Generic]()
    
    private var spellIndex: [String] = [String]()
    
    private let spellsTableView: UITableView = {
       let table = UITableView()
        table.register(SpellsTableViewCell.self, forCellReuseIdentifier: SpellsTableViewCell.identifier)
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        
        addSubViews()
        
        spellsTableView.delegate = self
        spellsTableView.dataSource = self
        
        applyConstraint()
        configureContents()
        fetchData()
    }
    
    private func configureNavigationBar() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "potion")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        navigationItem.title = "Sorcerer's Spells"
        navigationController?.navigationBar.tintColor = .systemPink
    }
    
    private func addSubViews() {
        view.addSubview(spellsTableView)
    }
    
    private func applyConstraint() {
        let tableViewConst = [
            spellsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            spellsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            spellsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            spellsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ]
        NSLayoutConstraint.activate(tableViewConst)
    }
    
    private func configureContents() {
        
    }
    
    private func fetchData() {
        APICaller.shared.getSpells { [weak self] result in
            switch result {
            case .success(let spells):
                for i in 0...9 {
                    if let index = spells[0].results?[i].index {
                        self?.spellIndex.append(index)
                    }
                }
                DispatchQueue.main.async {
                    self?.spellsTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SpellsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spellIndex.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpellsTableViewCell.identifier, for: indexPath) as? SpellsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = UIColor(named: "appSoftBrown")
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 10
        cell.layer.cornerRadius = 20
        
        cell.spellLabel.text = spellIndex[indexPath.row].localizedUppercase
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SpellDescriptionViewController()
        vc.spellIndex = spellIndex[indexPath.row].lowercased()
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }

}


