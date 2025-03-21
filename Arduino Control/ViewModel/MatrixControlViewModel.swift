//
//  MatrixControlViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation

class MatrixControlViewModel: ObservableObject {
    @Published var sendCommandTimer: Timer? = nil
    @Published var selectedMatrix = MatrixStorage.shared.matrixes.first!
    
    init() { selectedMatrix.index = 0 }
    
    func updateSelectedMatrix() {
        if sendCommandTimer == nil {
            sendCommandTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                let command = ControlCommand(device: "Matrix", action: 1, values: self.selectedMatrix.values.toIntArray())
                ConnectionService.sendRequest(command: command)
                self.sendCommandTimer = nil
            }
        }
    }
}
