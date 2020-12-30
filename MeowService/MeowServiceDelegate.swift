//
//  MeowServiceDelegate.swift
//  MeowService
//
//  Created by Linus Skucas on 12/30/20.
//

import Foundation

class MeowServiceDelegate: NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        let exportedObject = MeowService()
        newConnection.exportedInterface = NSXPCInterface(with: MeowServiceProtocol.self)
        newConnection.exportedObject = exportedObject
        newConnection.resume()
        return true
    }
}
