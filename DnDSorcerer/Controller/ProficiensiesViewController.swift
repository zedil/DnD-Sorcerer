//
//  PageSheetViewController.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import UIKit

class ProficiensiesViewController: UIViewController {
    
    public var itemName: String = ""
    
    private var proficiensies: [ProficiensiesSub] = [ProficiensiesSub]()
    private var classes: [Generic] = [Generic]()
    
    private let classCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(ClassesCollectionViewCell.self, forCellWithReuseIdentifier: ClassesCollectionViewCell.identifier)
        return collection
    }()
    
    private var proficiencyView = ProficiencyView()
    
    private let closeButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "appSoftBrown")
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: "ring")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let classesLabel: UILabel = {
        let label = UILabel()
        label.text = "Classes"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = UIColor(named: "appDarkest")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = UIColor(named: "appSoftBrown")
        stack.layer.cornerRadius = 15
        stack.spacing = 40
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(closeButtonView)
        closeButtonView.addSubview(closeButton)
        
        view.addSubview(imageView)
        
        view.addSubview(proficiencyView)
        view.addSubview(classesLabel)
        
        classCollectionView.delegate = self
        classCollectionView.dataSource = self
        view.addSubview(classCollectionView)
        
        configureContent()
        applyConstraints()
        
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getProficiensies(with: itemName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self?.proficiensies = results
                    self?.classes = results[0].classes
                    DispatchQueue.main.async {
                        self?.classCollectionView.reloadData()
                        
                        self?.proficiencyView.nameLabel.text = self?.proficiensies[0].name
                        self?.proficiencyView.typeLabel.text = self?.proficiensies[0].type
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func configureContent() {
        view.backgroundColor = .systemBackground
        
        proficiencyView.translatesAutoresizingMaskIntoConstraints = false
        proficiencyView.backgroundColor = UIColor(named: "appYellow")
        proficiencyView.layer.cornerRadius = 25
        proficiencyView.imageView.image = UIImage(named: "dagger")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        closeButtonView.addGestureRecognizer(tap)
        closeButton.addTarget(self, action: #selector(self.handleTap(_:)), for: .touchUpInside)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func applyConstraints() {
        
        let closeViewConst = [
            closeButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            closeButtonView.widthAnchor.constraint(equalToConstant: 40),
            closeButtonView.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(closeViewConst)
        
        let closeButtonConst = [
            closeButton.centerXAnchor.constraint(equalTo: closeButtonView.centerXAnchor),
            closeButton.centerYAnchor.constraint(equalTo: closeButtonView.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(closeButtonConst)
        
        let imgViewConst = [
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(imgViewConst)
        
        let proficiencyViewConst = [
            proficiencyView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            proficiencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            proficiencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(proficiencyViewConst)
        
        let classesLabelConst = [
            classesLabel.topAnchor.constraint(equalTo: proficiencyView.bottomAnchor, constant: 50),
            classesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            classesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(classesLabelConst)
        
        let collectionViewConst = [
            classCollectionView.topAnchor.constraint(equalTo: classesLabel.bottomAnchor, constant: 20),
            classCollectionView.leadingAnchor.constraint(equalTo: classesLabel.leadingAnchor, constant: 10),
            classCollectionView.trailingAnchor.constraint(equalTo: classesLabel.trailingAnchor, constant: -10),
            classCollectionView.heightAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(collectionViewConst)
    }
}

extension ProficiensiesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassesCollectionViewCell.identifier, for: indexPath) as? ClassesCollectionViewCell else {
            return UICollectionViewCell() }
        
        let title = classes[indexPath.row].name
        cell.classLabel.text = title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
