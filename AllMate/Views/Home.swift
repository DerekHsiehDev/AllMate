//
//  HomeView.swift
//  AllMate
//
//  Created by Derek Hsieh on 3/22/21.
//

import SwiftUI
import FirebaseAuth

struct Home: View {
    @State var selectedTab = "Home"
    @Namespace var animation
    @StateObject var modelData = AppStateModelView()
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { _ in
                ZStack {
                    // Tabs....
                    
           HomeView()
                .opacity(selectedTab == "Home" ? 1 : 0)
                    
                    Text("Activity")
                        .opacity(selectedTab == "Activity" ? 1 : 0)
                    
                    Text("Search")
                        .opacity(selectedTab == "Search" ? 1 : 0)
                    
                    Button(action: {
                            
                        do {
                            try Auth.auth().signOut()
                            UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
                            
                        } catch let error as NSError {
                            print ("Error signing out: %@", error)
                        }
                     
                        
                    }) {
                        Text("sign out")
                    }
                        .opacity(selectedTab == "Profile" ? 1 : 0)
                    
                }
            }
            .onChange(of: selectedTab) { (_) in
                switch(selectedTab) {
                case "Activity":
                    if !modelData.isActivityLoaded { modelData.loadActivity() }
                case "Search":
                    if !modelData.isSearchLoaded { modelData.loadSearch() }
                case "Profile":
                    if !modelData.isProfileLoaded { modelData.loadProfile() }
                default: ()
                }
            }
            
            // TabView
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { tab in
                    TabButton(title: tab.title, imageName: tab.imageName, animation: animation, selectedTab: $selectedTab)
                    
                    if tab != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 30)
            // for iPhones with old design (SE, 8)
            .padding(.bottom, edges!.bottom == 0 ? 15 : edges!.bottom)
            .background(Color("Tab Bar background"))
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color("Background").edgesIgnoringSafeArea(.all))
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


