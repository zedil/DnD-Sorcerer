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
    private var classes: [Classes] = [Classes]()
    
    private let classCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(ClassesCollectionViewCell.self, forCellWithReuseIdentifier: ClassesCollectionViewCell.identifier)
        return collection
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topSeperator: UIView = {
        let view = UIView()
        view.frame.size.width = 41
        view.frame.size.height = 4
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 2.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "nameLabel"
        label.textColor = UIColor(named: "appDarkest")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "typeLabel"
        label.textColor = UIColor(named: "appDarkest")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let classesLabel: UILabel = {
        let label = UILabel()
        label.text = "classesLabel"
        label.textColor = UIColor(named: "appDarkest")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let classesNameLabel: UILabel = {
        let label = UILabel()
        label.text = "classesNameLabel"
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
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(classesLabel)
        
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
                        
                        self?.nameLabel.text = self?.proficiensies[0].name
                        self?.typeLabel.text = self?.proficiensies[0].type
                    }
                    print("xxxx: \(results)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func configureContent() {
        view.backgroundColor = .systemBackground
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        closeButtonView.addGestureRecognizer(tap)
        closeButton.addTarget(self, action: #selector(self.handleTap(_:)), for: .touchUpInside)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func applyConstraints() {
        
        let closeViewConst = [
            closeButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
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
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(imgViewConst)
        
        let stackViewConst = [
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(stackViewConst)
        
        let collectionViewConst = [
            classCollectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 100),
            classCollectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            classCollectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
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
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
