//
//  LevelsViewController.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import UIKit

class LevelsViewController: UIViewController {
    
    private var levelsViewModel = LevelsViewModel()
    
    var spellIndex = "1"
    
    var textvalue = TextValueView()
    
    var levelView = LevelView()
    
    private let levelFeatureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(LevelFeatureCollectionViewCell.self, forCellWithReuseIdentifier: LevelFeatureCollectionViewCell.identifier)
        return collection
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setDelegates()
        addSubViews()
        
        getData()
        initViewModel()
        configureContent()
        configureTapGesture()
        
        subscribeViewModel()
        
        
    }
    
    private func addSubViews() {
        view.addSubview(levelView)
        let levelViewConst = [
            levelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            levelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            levelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            levelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250)
        ]
        NSLayoutConstraint.activate(levelViewConst)
        
        
        view.addSubview(levelFeatureCollectionView)
        
        let levelFeatureCollectionViewConst = [
            levelFeatureCollectionView.topAnchor.constraint(equalTo: levelView.bottomAnchor, constant: 20),
            levelFeatureCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            levelFeatureCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            levelFeatureCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ]
        NSLayoutConstraint.activate(levelFeatureCollectionViewConst)
    }
    
    private func setDelegates() {
        levelFeatureCollectionView.delegate = self
        levelFeatureCollectionView.dataSource = self
    }
    
    private func configureNavigationBar() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "potion")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        navigationItem.title = "Sorcerer's Levels"
        navigationController?.navigationBar.tintColor = .systemPink
    }
    
    private func initViewModel() {
        levelsViewModel.reloadCollectionView = {
            DispatchQueue.main.async {
                self.levelFeatureCollectionView.reloadData()
            }
        }
    }
    
    private func subscribeViewModel() {
        levelsViewModel.getDataDidSuccess = { [weak self] in
            guard let self = self else { return }
            print("xxxxx: \(self.levelsViewModel.profBonus)")
            print("xxxxx: \(self.levelsViewModel.abilitScore)")
            print("xxxxx: \(self.levelsViewModel.metamagicKnown)")
            print("xxxxx: \(self.levelsViewModel.sorceryPoints)")
            print("xxxxx: \(self.levelsViewModel.spellsKnown)")
            print("xxxxx: \(self.levelsViewModel.cantripsKnown)")
        }
    }
    
    private func getData() {
        levelsViewModel.fetchLevels()
    }
    
    private func configureContent() {
        levelView.levelTitle.text = "Level " + spellIndex + " ->"
        
    }
    
    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        levelView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        print("clickeddd")
    }
    
}


extension LevelsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levelsViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelFeatureCollectionViewCell.identifier, for: indexPath) as? LevelFeatureCollectionViewCell else {
            return UICollectionViewCell() }
        
        let cellItem = levelsViewModel.cellItemAt(indexPath: indexPath)
        cell.levelLabel.text = cellItem.titleText
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    
}
