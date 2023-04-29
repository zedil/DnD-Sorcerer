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
    
    //https://www.dnd5eapi.co/api/proficiencies/daggers
    
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
    
    func getProficiensies(completion: @escaping (Result<[Proficiencies], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.url)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Proficiencies.self, from: data)
                completion(.success([result]))
            } catch {
                completion(.failure(APIError.failed))
            }
        }
        
        task.resume()
    }
}
