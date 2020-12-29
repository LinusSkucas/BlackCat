//
//  AuthSheetView.swift
//  Black Cat
//
//  Created by Linus Skucas on 12/28/20.
//

import SwiftUI
import AppKit

struct AuthSheetView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) private var presentationMode
    @State private var isAuthenticating = false
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(nsImage: NSApplication.shared.applicationIconImage)
                Text("Black Cat")
                    .font(.title)
                    .fontWeight(.medium)
            }
            Spacer()
            HStack {
                Image(systemName: "bolt")
                    .foregroundColor(.green)
                    .font(.title)
                Text("Connect your GitHub account to begin organizing\nyour notifications.")
                    .fixedSize()
            }
            Spacer()
            GroupBox(label: Text("Permissions")) {
                VStack(alignment: .leading, spacing: 10.0) {
                    HStack(alignment: .top) {  // TODO: Refactor this
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .foregroundColor(.orange)
                            .font(.title)
                        Text("Black Cat needs access to your GitHub\nnotifications to help organize them.")
                            .font(.callout)
                            .fixedSize()
                    }
                    HStack(alignment: .top) {
                        Image(systemName: "externaldrive.connected.to.line.below")
                            .foregroundColor(.purple)
                            .font(.title)
                    VStack(alignment: .leading, spacing: 0.0) {
                            Text("To authenticate you with GitHub, Black Cat\nwill send a code to a server, which will return a token.\nThe server does not save the token and the token will not be transmitted\noff your computer.")
                            Link("Learn more about GitHub OAuth and Black Cat", destination: TokenManager.learnMoreOAuthGithub)
                        }
                        .font(.callout)
                        .fixedSize()
                    }
                }
            }
            Spacer()
            HStack {
                Button(isAuthenticating ? "Connecting..." : "Connect...") {
                    isAuthenticating.toggle()
                    openURL.callAsFunction(TokenManager.tokenURL)
                }
                if isAuthenticating {
                    ProgressView()  // TODO: don't change size of sheet when appearing
                        .scaleEffect(0.5, anchor: .center)
                }
            }
            .fixedSize(horizontal: true, vertical: true)
        }
        .padding()
        .onOpenURL { url in
            guard url.deeplinkType == .auth else { return }
            guard let queryParameters = url.queryParameters,
                  let code = queryParameters["code"] else { return }
            userData.tokenManager.getTokenFromCode(code) { token in
                guard let token = token else { return }  // TODO: Error handling
                userData.tokenManager.githubToken = token
                presentationMode.wrappedValue.dismiss()
                NSApplication.shared.windows.last!.close()  // Very, very hacky to close the window that is still loading, because open url opens a new window. TODO: Close the first window, or don't open a second window.
            }
        }
    }
}

struct AuthSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AuthSheetView()
    }
}
