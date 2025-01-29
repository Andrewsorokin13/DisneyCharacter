//
//  DisneyCharacter.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 20.01.2025.
//

import Foundation

struct DisneyAPIResponse: Codable {
    let info: PageInfo
    let data: [DisneyCharacter]
}

struct PageInfo: Codable {
    let count: Int
    let totalPages: Int
    let previousPage: String?
    let nextPage: String?
}

struct DisneyCharacter: Codable {
    let id: Int
    let films: [String]?
    let shortFilms: [String]?
    let tvShows: [String]?
    let sourceUrl: String
    let name: String
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case films, shortFilms, tvShows
        case sourceUrl, name, imageUrl
    }
    
    var getImageUrl: URL? {
        guard let imageUrl else { return nil }
        return URL(string: imageUrl)
    }
}


