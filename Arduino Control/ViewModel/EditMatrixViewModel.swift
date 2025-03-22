//
//  EditMatrixViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation

class EditMatrixViewModel: ObservableObject {
    @Published var isOn = true
    
    func updateLedState(_ selectedMatrix: Matrix, _ location: CGPoint, _ cellSize: Double, _ columns: Int, _ rows: Int) -> Matrix {
        var selectedMatrix = selectedMatrix
        let x = Int(location.x / cellSize)
        let y = Int(location.y / cellSize)
        
        if (0..<columns).contains(x), (0..<rows).contains(y) {
            if selectedMatrix.values[y][x] != self.isOn {
                Haptic.feedback(.selection)
                let command = ControlCommand(device: "Matrix", action: 0, values: [[x, y, self.isOn ? 1 : 0]])
                ConnectionService.sendRequest(command: command)
            }
            selectedMatrix.values[y][x] = self.isOn
        }
        return selectedMatrix
    }
}
