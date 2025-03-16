//
//  SwiftUIView.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("arduinoIP") var arduinoIP = "192.168.4.1"
    
    var body: some View {
        NavigationView {
            List {
                TextField("Ip", text: $arduinoIP)
                Text("Connect to Arduino Wifi to function.")
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
