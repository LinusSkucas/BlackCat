//
//  MeowServiceProtocol.swift
//  MeowService
//
//  Created by Linus Skucas on 12/30/20.
//

import Foundation

@objc public protocol MeowServiceProtocol {
    func upperCaseString(_ string: String, withReply reply: @escaping (String) -> Void)
}
