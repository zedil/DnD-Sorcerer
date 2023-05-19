//
//  LevelsViewModel.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 19.05.2023.
//

import Foundation
import UIKit

class LevelsViewModel {
    
    var levels: [Generic] = [Generic]()
    var reloadCollectionView: (()->Void)?
    var getDataDidSuccess: (()->Void)?
    private var cellItems: [LevelsCellViewModel] = []
    
    var profBonus: Int?
    var abilitScore: Int?
    var cantripsKnown: Int?
    var spellsKnown: Int?
    var sorceryPoints: Int?
    var metamagicKnown: Int?
    
    
    var cellViewModels: [LevelsCellViewModel] = [LevelsCellViewModel]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> LevelsCellViewModel {
        return cellItems[indexPath.row]
    }
    
    func didSelectItemAt(indexPath: IndexPath) -> LevelsCellViewModel {
        let cellItem = cellItemAt(indexPath: indexPath)
        return cellItem
    }
    
    func fetchLevels() {
        APICaller.shared.getLevels(with: "1") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let levels):
                self.createCell(data: levels)
                self.createCustomInfo(data: levels)
                self.reloadCollectionView?()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createCell(data: [Levels]) {
        self.levels = data[0].features
        let cellItem = levels.map({ LevelsCellViewModel(titleText: $0.name, indexText: $0.index )})
        self.cellItems = cellItem
    }
    
    func createCustomInfo(data: [Levels]) {
        self.profBonus = data[0].prof_bonus
        self.abilitScore = data[0].ability_score_bonuses
        self.cantripsKnown = data[0].spellcasting.cantrips_known
        self.spellsKnown = data[0].spellcasting.spells_known
        self.sorceryPoints = data[0].class_specific.sorcery_points
        self.metamagicKnown = data[0].class_specific.metamagic_known
        self.getDataDidSuccess?()
    }
    
}

struct LevelsCellViewModel {
    let titleText: String
    let indexText: String
}
