//
//  HomeViewModel.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 5.05.2023.
//

import Foundation

import UIKit

class HomeViewModel {

    var proficiensies: [Generic] = [Generic]()
    var ability: [Ability] = [Ability]()
    var reloadCollectionView: (()->Void)?
    private var cellItems: [ProficienciesCellViewModel] = []
    
    var cellViewModels: [ProficienciesCellViewModel] = [ProficienciesCellViewModel]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> ProficienciesCellViewModel {
        return cellItems[indexPath.row]
    }
    
    
    func didSelectItemAt(indexPath: IndexPath) -> ProficienciesCellViewModel {
        let cellItem = cellItemAt(indexPath: indexPath)
        return cellItem
    }
    
    
     func fetchSorcerer() {
        APICaller.shared.getSorcererBasicInfo { [weak self] result in
            switch result {
            case .success(let sorcerer):
                self?.createCell(data: sorcerer)
                self?.reloadCollectionView?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createCell(data: [Sorcerer]) {
        self.proficiensies = data[0].proficiencies
        let cellItem = proficiensies.map( { ProficienciesCellViewModel(titleText: $0.name, indexText: $0.index)})
        self.cellItems = cellItem
    }
    
}

struct ProficienciesCellViewModel {
    let titleText: String
    let indexText: String
}
