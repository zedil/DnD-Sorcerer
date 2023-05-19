//
//  APICaller.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import Foundation

struct Constants {
    static let baseUrl = "https://www.dnd5eapi.co/api"
    static let url = "/classes/sorcerer"
    static let proficiencies = "/proficiencies/"
    ///api/ability-scores/con
    static let ability = "/ability-scores/"
    static let skill = "/skills/"
    //https://www.dnd5eapi.co/api/spells/acid-splash
    ///https://www.dnd5eapi.co/api/classes/sorcerer/spells
    static let spells = "/spells"
    ///https://www.dnd5eapi.co/api/features/flexible-casting-creating-spell-slots
    ////api/classes/sorcerer/levels/ -> levels
    ///
    ///
    ///https://www.dnd5eapi.co/api/features/flexible-casting-creating-spell-slots
    ///https://www.dnd5eapi.co/api/classes/sorcerer/levels/1

    static let levels = "/levels/"
    
    // index    :    deception
    // url    :    /api/skills/deception
}

enum APIError: Error {
    case failed
}

class APICaller {
    
    static let shared = APICaller()
    
    func getSorcererBasicInfo(completion: @escaping (Result<[Sorcerer], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl + Constants.url)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Sorcerer.self, from: data)
                completion(.success([result]))
            } catch {
                completion(.failure(APIError.failed))
            }
        }
        task.resume()
    }
    
    func getProficiensies(with query: String, completion: @escaping (Result<[ProficiensiesSub], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseUrl + Constants.proficiencies + query)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ProficiensiesSub.self, from: data)
                completion(.success([result]))
            } catch {
                completion(.failure(APIError.failed))
            }
        }
        task.resume()
    }
    
    func getAbility(with query: String, completion: @escaping (Result<[Ability], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseUrl + Constants.ability + query)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Ability.self, from: data)
                completion(.success([result]))
            } catch {
                completion(.failure(APIError.failed))
            }
        }
        task.resume()
    }
    
    func getSkill(with query: String, completion: @escaping (Result<[Skills], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseUrl + Constants.skill + query)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(Skills.self, from: data)
                completion(.success([result]))
            } catch {
                completion(.failure(APIError.failed))
            }
        }
        task.resume()
    }
    
    func getSpells(completion: @escaping (Result<[Spells], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl + Constants.url + Constants.spells)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(Spells.self, from: data)
                completion(.success([result]))
            } catch {
                completion(.failure(APIError.failed))
            }
        }
        task.resume()
    }
    
    func getSkillDesc(with query: String, completion: @escaping (Result<[SpellDescription], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseUrl + Constants.spells + "/" + query)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(SpellDescription.self, from: data)
                completion(.success([result]))
            } catch {
                completion(.failure(APIError.failed))
            }
        }
        task.resume()
    }
    
    func getLevels(with query: String, completion: @escaping (Result<[Levels], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseUrl + Constants.url + Constants.levels + query)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(Levels.self, from: data)
                completion(.success([result]))
            } catch {
                completion(.failure(APIError.failed))
            }
        }
        task.resume()
    }
}
