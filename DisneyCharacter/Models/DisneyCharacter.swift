//
//  DisneyCharacter.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 20.01.2025.
//

import Foundation

// Главная модель ответа
struct DisneyAPIResponse: Codable {
    let info: PageInfo
    let data: [DisneyCharacter]
}

// Информация о страницах
struct PageInfo: Codable {
    let count: Int
    let totalPages: Int
    let previousPage: String?
    let nextPage: String?
}

// Модель данных для персонажа
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
}


