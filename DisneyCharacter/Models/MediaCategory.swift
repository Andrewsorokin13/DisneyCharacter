//
//  Categorys.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 28.01.2025.
//

import Foundation

struct DisneyCharacterSection {
    let title: MediaCategory
    let items: [String]
}

enum MediaCategory {
    case films
    case tvShows
    case shortFilms
    
    var categoryName: String {
        switch self {
        case .films:
            return "Films 🎥"
        case .tvShows:
            return "TV shows 📺"
        case .shortFilms:
            return "Video Games  🎮"
        }
    }
}
