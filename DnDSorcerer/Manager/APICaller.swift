//
//  APICaller.swift
//  DnDSorcerer
//
//  Created by Dilara Şimşek on 29.04.2023.
//

import Foundation

struct Constants {
    static let url = "https://www.dnd5eapi.co/api/classes/sorcerer"
    static let proficiencies = "https://www.dnd5eapi.co/api/proficiencies/"
}

enum APIError: Error {
    case failed
}

class APICaller {
    
    static let shared = APICaller()
    
    func getSorcererBasicInfo(completion: @escaping (Result<[Sorcerer], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.url)") else { return }
        
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
        
        guard let url = URL(string: "\(Constants.proficiencies + query)") else { return }
        
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
}
