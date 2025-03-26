//
//  MatrixViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation
import SwiftUI

class MatrixViewModel: ObservableObject {
    @AppStorage("isOn") var isOn = true
    
    func updateLedState(_ selectedMatrix: inout Matrix, _ location: CGPoint, _ cellSize: Double) {
        let x = Int(location.x / cellSize)
        let y = Int(location.y / cellSize)
        
        if (0..<12).contains(x), (0..<8).contains(y) {
            if selectedMatrix.values[y][x] != self.isOn {
                Haptic.feedback(.selection)
                let command = ControlCommand(device: "Matrix", action: 0, values: [[x, y, self.isOn ? 1 : 0]])
                ConnectionService.sendRequest(command: command)
            }
            selectedMatrix.values[y][x] = self.isOn
        }
    }
}
