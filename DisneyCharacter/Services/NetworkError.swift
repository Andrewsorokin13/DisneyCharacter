//
//  NetworkError.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 21.01.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
