//
//  DisneyAPIResponse.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 02.02.2025.
//

import Foundation

struct DisneyAPIResponse: Codable {
    let info: PageInfo
    let data: [DisneyCharacter]
    
    init(info: PageInfo, data: [DisneyCharacter]) {
        self.info = info
        self.data = data
    }
    
    init(responseDetails: [String: Any]) {
        
        guard let infoDict = responseDetails["info"] as? [String: Any],
              let dataArray = responseDetails["data"] as? [[String: Any]]
        else {
            info = PageInfo(count: 0, totalPages: 0, previousPage: nil, nextPage: nil)
            data = []
            return
        }
        info = PageInfo(pageDetails: infoDict)
        data = dataArray.map { DisneyCharacter(characterDetails: $0) }
    }
    
    static func getResponse(from value: Any) -> DisneyAPIResponse {
        guard let responseDetails = value as? [String: Any] else {
            return DisneyAPIResponse(
                info: PageInfo(
                    count: 0,
                    totalPages: 0,
                    previousPage: nil,
                    nextPage: nil
                ),
                data:  []
            )
        }
        return DisneyAPIResponse(responseDetails: responseDetails)
    }
}
