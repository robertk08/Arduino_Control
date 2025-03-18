//
//  SwiftUIView.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                TextField("Ip", text: $viewModel.arduinoIP)
                Text("Connect to Arduino Wifi to function.")
                Button("Change App Icon") {
                    viewModel.isSheetPresented = true
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $viewModel.isSheetPresented) {
                IconSelectionView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
