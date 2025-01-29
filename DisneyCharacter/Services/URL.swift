//
//  URL.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 27.01.2025.
//

import Foundation

enum Link {
    case characters
    
    var url: URL? {
        switch self {
        case .characters:
             URL(string: "https://api.disneyapi.dev/character")
        }
    }
}
