//
//  Ability.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 30.04.2023.
//

import Foundation

struct Ability: Codable {
    let index: String?
    let name: String?
    let full_name: String?
    let desc: [String]?
    let skills: [Generic]?
}
