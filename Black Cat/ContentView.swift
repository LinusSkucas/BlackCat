//
//  ContentView.swift
//  Black Cat
//
//  Created by Linus Skucas on 12/27/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State var isAuthSheetShowing = false
    
    var body: some View {
        Text("Hello, World!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear(perform: {
                if userData.tokenManager.githubToken == nil {
                    isAuthSheetShowing = true
                }
            })
            .sheet(isPresented: $isAuthSheetShowing, content: {
                AuthSheetView()
                    .environmentObject(userData)
            })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
