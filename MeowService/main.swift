//
//  main.swift
//  MeowService
//
//  Created by Linus Skucas on 12/30/20.
//

import Foundation

let delegate = MeowServiceDelegate()
let listener = NSXPCListener.service()
listener.delegate = delegate
listener.resume()
