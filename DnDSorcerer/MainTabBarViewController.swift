//
//  MainTabBarViewController.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        let vc0 = UINavigationController(rootViewController: HomeViewController())
        let vc1 = UINavigationController(rootViewController: SpellsViewController())
        let vc2 = UINavigationController(rootViewController: EquipmentViewController())
        let vc3 = UINavigationController(rootViewController: SubClassViewController())
        let vc4 = UINavigationController(rootViewController: ThrowsViewController())
        
        vc0.tabBarItem.image = UIImage(named: "potion")?.imageResized(to: CGSize(width: 32, height: 32))
        vc1.tabBarItem.image = UIImage(named: "spell")?.imageResized(to: CGSize(width: 32, height: 32))
        vc2.tabBarItem.image = UIImage(named: "equipment")?.imageResized(to: CGSize(width: 32, height: 32))
        vc3.tabBarItem.image = UIImage(named: "note")?.imageResized(to: CGSize(width: 32, height: 32))
        vc4.tabBarItem.image = UIImage(named: "ring")?.imageResized(to: CGSize(width: 32, height: 32))
        
        vc0.title = "Sorcerer"
        vc1.title = "Spells"
        vc2.title = "Equipments"
        vc3.title = "Sub Classes"
        vc4.title = "Throws"
        
        tabBar.tintColor = UIColor(named: "appSoftBrown")
        
        setViewControllers([vc0, vc1, vc2, vc3, vc4], animated: true)
    }
}

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
