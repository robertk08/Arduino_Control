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
        let y = Int(location.x / cellSize)
        let x = Int(location.y / cellSize)
        
        if (0..<selectedMatrix.values.count).contains(x), (0..<selectedMatrix.values[0].count).contains(y), selectedMatrix.values[x][y] != self.isOn {
            Haptic.feedback(.selection)
            let command = ControlCommand(device: "Matrix", action: 0, values: [[y, x, self.isOn ? 1 : 0]])
            ConnectionService.sendRequest(command: command)
            selectedMatrix.values[x][y] = self.isOn
        }
    }
}
