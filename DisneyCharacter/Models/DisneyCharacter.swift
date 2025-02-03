//
//  DisneyCharacter.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 20.01.2025.
//

import Foundation

struct DisneyCharacter: Codable {
    let id: Int
    let films: [String]?
    let shortFilms: [String]?
    let tvShows: [String]?
    let sourceUrl: String
    let name: String
    let imageUrl: String?
    
    var getImageUrl: URL? {
        guard let imageUrl else { return nil }
        return URL(string: imageUrl)
    }
    
    init(id: Int, films: [String]?, shortFilms: [String]?, tvShows: [String]?, sourceUrl: String, name: String, imageUrl: String?) {
        self.id = id
        self.films = films
        self.shortFilms = shortFilms
        self.tvShows = tvShows
        self.sourceUrl = sourceUrl
        self.name = name
        self.imageUrl = imageUrl
    }
    
    init(characterDetails: [String: Any]) {
        id = characterDetails["_id"] as? Int ?? 0
        films = characterDetails["films"] as? [String]
        shortFilms = characterDetails["shortFilms"] as? [String]
        tvShows = characterDetails["tvShows"] as? [String]
        sourceUrl = characterDetails["sourceUrl"] as? String ?? ""
        name = characterDetails["name"] as? String ?? ""
        imageUrl = characterDetails["imageUrl"] as? String
    }
    
    static func getCharacters(from value: Any) -> [DisneyCharacter] {
        guard let charactersDetails = value as? [[String: Any]] else { return [] }
        return charactersDetails.map { DisneyCharacter(characterDetails: $0) }
    }
}


