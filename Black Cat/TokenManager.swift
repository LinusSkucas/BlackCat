//
//  TokenManager.swift
//  Black Cat
//
//  Created by Linus Skucas on 12/28/20.
//

import KeychainAccess
import SwiftUI
import Alamofire  // TODO: Seperate networking out

class TokenManager {
    static var tokenURL: URL {
        let queryItems = [URLQueryItem(name: "client_id", value: "bf6b0bf88090391ff214"), URLQueryItem(name: "redirect_uri", value: "blackcat://auth"), URLQueryItem(name: "scope", value: "notifications")]  // TODO: STATE TO PREVENT CSRF
        var urlComponents = URLComponents(string: "https://github.com/login/oauth/authorize")!
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
    static let codeExchangeURL = URL(string: "https://Scrapple.pythonanywhere.com/catAuth")!
    static let learnMoreOAuthGithub = URL(string: "https://github.com/LinusS1/BlackCat/wiki/OAuth-with-GitHub")!
    
    private let keychain = Keychain(service: "Black Cat")
    private let item = "github"
        
    var githubToken: String? {
        get {
            self.keychain[item]
        }
        set {
            self.keychain[item] = newValue
        }
    }
    
    func getTokenFromCode(_ code: String, completion: @escaping (String?) -> Void) {
        AF.request(TokenManager.codeExchangeURL, method: .post, parameters: ["code": code], encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .responseData { data in
                guard let token = String(data: data.data!, encoding: .utf8) else { return completion(nil) }
                completion(token)
            }
    }
}
