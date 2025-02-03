//
//  NetworkManager.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 22.01.2025.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    //MARK: - Private property
    
    private let urlSession = URLSession.shared
    private let maxRetryCount = 3
    
    //MARK: - Static property
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Public method
    
    func fetch (from  url: URL, completion: @escaping (Result<DisneyAPIResponse, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let characters = DisneyAPIResponse.getResponse(from: value)
                    completion(.success(characters))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: URL, completion: @escaping (Result<Data, AFError>)-> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
