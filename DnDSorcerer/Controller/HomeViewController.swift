//
//  HomeViewController.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var proficiensies: [Proficiencies] = [Proficiencies]()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "appSoftBrown")
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sorcererImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "sorcerer")
        return imgView
    }()
    
    private let hitDieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hit Die Score"
        return label
    }()
    
    private let hitDieScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    private let sorcererProficienciesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(ProficiensiesCollectionViewCell.self, forCellWithReuseIdentifier: ProficiensiesCollectionViewCell.identifier)
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        
        sorcererProficienciesCollectionView.delegate = self
        sorcererProficienciesCollectionView.dataSource = self
        
        addSubViews()
        configureContents()
        fetchSorcerer()
    }
    
    private func configureNavigationBar() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "potion")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        navigationItem.title = "Sorcerer"
        navigationController?.navigationBar.tintColor = .systemPink
    }
    
    private func addSubViews() {
        view.addSubview(contentView)
        view.addSubview(sorcererProficienciesCollectionView)
        contentView.addSubview(sorcererImageView)
    }
    
    private func configureContents() {
        
        let contentViewConst = [
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 400),
            contentView.widthAnchor.constraint(equalToConstant: 400)
        ]
        NSLayoutConstraint.activate(contentViewConst)
        
        let sorcererImgViewConst = [
            sorcererImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sorcererImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            sorcererImageView.heightAnchor.constraint(equalToConstant: 400),
            sorcererImageView.widthAnchor.constraint(equalToConstant: 400)
        ]
        NSLayoutConstraint.activate(sorcererImgViewConst)
        
        let sorcererProficienciesCollectionViewConst = [
            sorcererProficienciesCollectionView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 50),
            sorcererProficienciesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sorcererProficienciesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sorcererProficienciesCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(sorcererProficienciesCollectionViewConst)
        
        
    }
    
    private func fetchSorcerer() {
        APICaller.shared.getSorcererBasicInfo { [weak self] result in
            switch result {
            case .success(let sorcerer):
                self?.proficiensies = sorcerer[0].proficiencies
                DispatchQueue.main.async {
                    self?.sorcererProficienciesCollectionView.reloadData()
                }
                print(sorcerer)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return proficiensies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProficiensiesCollectionViewCell.identifier, for: indexPath) as? ProficiensiesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = proficiensies[indexPath.row].name
        cell.proficiencyName.text = title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItemName = proficiensies[indexPath.row].index
        
        let vc = ProficiensiesViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.itemName = selectedItemName
        self.present(vc, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
