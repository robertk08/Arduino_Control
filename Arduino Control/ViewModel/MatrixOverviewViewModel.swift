//
//  MatrixOverviewViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation

class MatrixOverviewViewModel: ObservableObject {
    @Published var showListView = false
    
    func newSelectedMatrix(_ selectedMatrix: inout Matrix, newSelectedMatrix: Matrix, index: Int) {
        selectedMatrix = newSelectedMatrix
        selectedMatrix.index = index
        let command = ControlCommand(device: "Matrix", action: 1, values: selectedMatrix.values.toIntArray())
        ConnectionService.sendRequest(command: command)
        Haptic.feedback(.selection)
    }
}
