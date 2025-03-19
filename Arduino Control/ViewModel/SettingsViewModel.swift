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
    @Published var isSheetPresented = false
}
