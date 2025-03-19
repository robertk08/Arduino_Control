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
                Toggle("Show LED Control", isOn: $viewModel.showLEDControl)
                    .tint(.accentColor)
                TextField("Ip", text: $viewModel.arduinoIP)
                    .onTapGesture {
                        Haptic.feedback(.selection)
                    }
                Text("Connect to Arduino Wifi to function.")
                Button("Change App Icon") {
                    Haptic.feedback(.success)
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
