//
//  Identifiers.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 29.01.2025.
//

import Foundation

// MARK: - Identifiers Enum
enum Identifiers {
    enum CollectionViewCell {
        case characterCell
        
        var identifier: String {
            switch self {
            case .characterCell: "characterCollectionViewCell"
            }
        }
    }
    
    enum Segue {
        case characterDetailsShow
        case webView
        
        var identifier: String {
            switch self {
            case .characterDetailsShow: "showCharacterDetails"
            case .webView : "showWebView"
            }
        }
    }
    
    enum TableViewCell {
        case characterDetailCell
        
        var identifier: String {
            switch self {
            case .characterDetailCell: "characterDetailTableViewCell"
            }
        }
    }
    
}
