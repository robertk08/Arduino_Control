//
//  SettingsViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("arduinoIP") var arduinoIP = "192.168.4.1"
    @AppStorage("showLEDControl") var showLEDControl = true
    @AppStorage("angleResolution") var angleResolution: Double = 1.0
    @AppStorage("positionTolerance") var positionTolerance: Double = 1.0
    @Published var isIconSelectionViewPresented = false
}
