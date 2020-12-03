//
//  RSSFeed.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/2/20.
//

import Foundation

enum RSSEndpoint {
    case Opinion
    case WorldNews
    case USBusiness
    case MarketsNews
    case TechnologyWhatsNew
    case Lifestyle
    
    var url: URL {
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
        return URL(string: "https://feeds.a.dj.com/rss/\(fileName).xml")!
    }
}
