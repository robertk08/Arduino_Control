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
        NavigationStack {
            List {
                Toggle("Show LED Control", isOn: $viewModel.showLEDControl)
                    .tint(.accentColor)
                TextField("Ip", text: $viewModel.arduinoIP)
                Button("Change App Icon") {
                    Haptic.feedback(.rigid)
                    viewModel.isIconSelectionViewPresented = true
                }
                VStack {
                    Text("Ändern die Geschwindigkeit für die Inverse-Kinematik:")
                        .underline()
                        .multilineTextAlignment(.center)
                    
                    Slider(value: $viewModel.angleResolution, in: 0.25...5)
                    Text(String(format: "%.2f", viewModel.angleResolution) + " Grad-Schritte für Brute-Force")
                    
                    Slider(value: $viewModel.positionTolerance, in: 0.1...5)
                    Text(String(format: "%.2f", viewModel.positionTolerance) + " Fehler-Toleranz für Zielposition")
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
