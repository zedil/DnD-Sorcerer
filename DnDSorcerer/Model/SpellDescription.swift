//
//  SpellDescription.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 3.05.2023.
//

import Foundation

struct SpellDescription: Codable {
    let name: String?
    let desc: [String]?
    let range: String?
    let duration: String?
    let school: Generic?
    let classes: [Generic]?
}
