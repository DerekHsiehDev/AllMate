//
//  ContentView.swift
//  AllMate
//
//  Created by Derek Hsieh on 3/22/21.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isLoggedIn") var isUserLoggedIn = false
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        
        if isUserLoggedIn {
            Home()
                .transition(.slide)
                .preferredColorScheme(.dark)
                .onAppear {
                    userViewModel.fetchUserData()
                }
                .environmentObject(userViewModel)
        } else {
            LoginHomeView()
                .transition(.opacity)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
