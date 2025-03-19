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
                Button("Change App Icon") {
                    Haptic.feedback(.success)
                    viewModel.isIconSelectionViewPresented = true
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $viewModel.isIconSelectionViewPresented) {
                IconSelectionView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
