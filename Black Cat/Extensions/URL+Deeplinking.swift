//
//  URL+Deeplinking.swift
//  Black Cat
//
//  Created by Linus Skucas on 12/28/20.
//

import Foundation

extension URL {
    var isDeeplink: Bool {
        return scheme == "blackcat"
    }
    
    var deeplinkType: DeeplinkType? {
        guard isDeeplink else { return nil }
        
        switch host {
        case "auth": return .auth
        default: return nil
        }
    }
}

enum DeeplinkType {
    case auth
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
