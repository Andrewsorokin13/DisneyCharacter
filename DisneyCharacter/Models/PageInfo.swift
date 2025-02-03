//
//  PageInfo.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 02.02.2025.
//

import Foundation

struct PageInfo: Codable {
    let count: Int
    let totalPages: Int
    let previousPage: String?
    let nextPage: String?
    
    init(count: Int, totalPages: Int, previousPage: String?, nextPage: String?) {
        self.count = count
        self.totalPages = totalPages
        self.previousPage = previousPage
        self.nextPage = nextPage
    }
    
    init(pageDetails: [String: Any]) {
        count = pageDetails["count"] as? Int ?? 0
        totalPages = pageDetails["totalPages"] as? Int ?? 0
        previousPage = pageDetails["previousPage"] as? String
        nextPage = pageDetails["nextPage"] as? String
    }
}
