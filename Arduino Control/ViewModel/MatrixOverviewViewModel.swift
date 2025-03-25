//
//  MatrixOverviewViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation

class MatrixOverviewViewModel: ObservableObject {
    @Published var showListView = false
    @Published var sendCommandTimer: Timer? = nil
    var selectedMatrix: Matrix?
    
    func updateSelectedMatrix(_ selectedMatrix: Matrix) {
        if selectedMatrix.id != self.selectedMatrix?.id {
            if sendCommandTimer == nil {
                sendCommandTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                    let command = ControlCommand(device: "Matrix", action: 1, values: selectedMatrix.values.toIntArray())
                    ConnectionService.sendRequest(command: command)
                    self.sendCommandTimer = nil
                }
            }
            self.selectedMatrix = selectedMatrix
        }
    }
}
