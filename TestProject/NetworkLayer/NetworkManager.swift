//
//  NetworkManager.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()

    public init() {}
    
    func get<Article: Decodable>(url: String, completion: @escaping ((Result<Article, Error>) -> Void)) {
        
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared
            .dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let error {
                print(error.localizedDescription)
            }
            
            guard let data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(Article.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                print("Decoding failed with error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


