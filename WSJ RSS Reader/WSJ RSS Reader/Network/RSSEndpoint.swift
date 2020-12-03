//
//  RSSFeed.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/2/20.
//

import Foundation

enum RSSEndpoint: String, CaseIterable, Identifiable {
    var id: String { return rawValue }
    
    case Opinion
    case WorldNews
    case USBusiness
    case MarketsNews
    case TechnologyWhatsNew
    case Lifestyle
    
    var title: String {
        let localizedString: LocalizedStrings
        switch self {
        case .Opinion:
            localizedString = .OpinionTitle
        case .WorldNews:
            localizedString = .WorldNewsTitle
        case .USBusiness:
            localizedString = .USBusinessTitle
        case .MarketsNews:
            localizedString = .MarketsNewsTitle
        case .TechnologyWhatsNew:
            localizedString = .TechnologyWhatsNewTitle
        case .Lifestyle :
            localizedString = .LifestyleTitle
        }
        return localizedString.localized
    }
    
    var scheme: String { "https" }
    var host: String { "feeds.a.dj.com" }
    var path: String {
        let fileName: String
        switch self {
        case .Opinion:
            fileName = "RSSOpinion"
        case .WorldNews:
            fileName = "RSSWorldNews"
        case .USBusiness:
            fileName = "WSJcomUSBusiness"
        case .MarketsNews:
            fileName = "RSSMarketsMain"
        case .TechnologyWhatsNew:
            fileName = "RSSWSJD"
        case .Lifestyle:
            fileName = "RSSLifestyle"
        }
        return "/rss/\(fileName).xml"
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}
