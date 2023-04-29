//
//  Proficiencies.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import Foundation

struct Proficiensies: Codable {
    let index: String
    let type: String
    let name: String
    let classes: [Classes]
}

struct Classes: Codable {
    let index: String
    let name: String
    let url: String
}
