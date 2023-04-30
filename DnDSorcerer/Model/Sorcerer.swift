//
//  Sorcerer.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import Foundation

struct Sorcerer: Codable {
    let index: String
    let name: String
    let hit_die: Int
    let proficiencies: [Generic]
    let saving_throws: [Generic]?
}

struct Generic: Codable {
    let index: String
    let name: String
    let url: String
}
