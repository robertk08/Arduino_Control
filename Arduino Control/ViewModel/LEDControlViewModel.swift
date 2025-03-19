//
//  LEDControlViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import Foundation
import SwiftUI

class LEDControlViewModel: ObservableObject {
    @Published var showSettingsView = false
    @AppStorage("showLEDControl") var showLEDControl = true
    @Published var selectedMatrix = MatrixStorage.shared.matrixes.first!

}
