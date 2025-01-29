//
//  NetworkManager.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 22.01.2025.
//

import Foundation

final class NetworkManager {
    
    //MARK: - Private property
    
    private let urlSession = URLSession.shared
    
    //MARK: - Static property
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Public method
    
    func fetch<T: Codable>(_ type: T.Type, from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        urlSession.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
                
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
}
