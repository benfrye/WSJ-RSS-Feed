//
//  LocalizedStrings.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/3/20.
//

import Foundation

enum LocalizedStrings: String {
    case WallStreetJournal
    case OpinionTitle
    case WorldNewsTitle
    case USBusinessTitle
    case MarketsNewsTitle
    case TechnologyWhatsNewTitle
    case LifestyleTitle
    case FetchError
    case Dismiss
    
    var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
