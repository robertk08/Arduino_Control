//
//  MainView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            LEDControlView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
