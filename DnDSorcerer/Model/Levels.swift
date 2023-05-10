//
//  Levels.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 10.05.2023.
//

import Foundation

struct Levels: Codable {
    let level: Int
    let ability_score_bonuses: Int
    let prof_bonus: Int
    let features: [Generic]
    let spellcasting: SpellCasting
    let class_specific: ClassSpesific
}

struct SpellCasting: Codable {
    let cantrips_known: Int
    let spells_known: Int
}

struct ClassSpesific: Codable {
    let sorcery_points: Int
    let metamagic_known: Int
}


