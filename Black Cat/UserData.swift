//
//  UserData.swift
//  Black Cat
//
//  Created by Linus Skucas on 12/28/20.
//

import Foundation
import SwiftUI

class UserData: ObservableObject {
    @Published var tokenManager = TokenManager()
}
