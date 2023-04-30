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
}
