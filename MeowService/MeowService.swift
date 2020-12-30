//
//  MeowService.h
//  MeowService
//
//  Created by Linus Skucas on 12/30/20.
//

import Foundation

class MeowService: NSObject, MeowServiceProtocol {
    func upperCaseString(_ string: String, withReply reply: @escaping (String) -> Void) {
        let response = string.uppercased()
        reply(response)
    }
}
