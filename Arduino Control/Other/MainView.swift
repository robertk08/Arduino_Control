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
                    Label("LED", systemImage: "memorychip")
                }
            
            AnimationListView()
                .tabItem {
                    Label("Animation", systemImage: "circle.dotted.and.circle")
                }
            
            MotorControlView()
                .tabItem {
                    Label("Motor", systemImage: "gyroscope")
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
