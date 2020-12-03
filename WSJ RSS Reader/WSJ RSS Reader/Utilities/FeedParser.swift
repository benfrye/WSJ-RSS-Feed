//
//  FeedParser.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/2/20.
//

import Foundation
import Combine

enum FeedParserError: Error {
    case UnknownError
}

final class FeedParser: NSObject, XMLParserDelegate {
    private enum AttributeKeys: String, CaseIterable {
        case item
        case title
        case link
        case description
        case pubDate
    }
    
    private var feed: Feed?
    private var error: Error?
    
    private var currentItem: Item?
    private var currentValue: String?
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss z"
        return dateFormatter
    }()
    
    func parse(_ data: Data) throws -> Feed {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()

        if let feed = feed {
            return feed
        } else {
            throw error ?? FeedParserError.UnknownError
        }
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        feed = Feed()
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        if elementName == AttributeKeys.item.rawValue {
            currentItem = Item()
        } else if let _ = AttributeKeys(rawValue: elementName) {
            currentValue = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue? += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == AttributeKeys.item.rawValue {
            if let item = currentItem {
                feed?.items.append(item)
                currentItem = nil
            }
        } else if let elementKey = AttributeKeys(rawValue: elementName) {
            switch elementKey {
            case .description:
                currentItem?.description = currentValue
            case .link:
                currentItem?.link = currentValue
            case .pubDate:
                if let currentValue = currentValue, let date = dateFormatter.date(from: currentValue) {
                    currentItem?.pubDate = date
                }
            case .title:
                currentItem?.title = currentValue
            case .item:
                // no-op
                break
            }
            currentValue = nil
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        error = parseError
    }
}
