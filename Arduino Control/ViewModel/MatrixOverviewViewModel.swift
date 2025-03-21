//
//  MatrixOverviewViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation
import SwiftUI

class MatrixOverviewViewModel: ObservableObject {
    @Published var showListView = false
    @ObservedObject var storage = MatrixStorage.shared
    
    func newSelectedMatrix(_ selectedMatrix: Matrix, index: Int) -> Matrix {
        var selectedMatrix = selectedMatrix
        selectedMatrix = storage.matrixes[index]
        selectedMatrix.index = index
        let command = ControlCommand(device: "Matrix", action: 1, values: selectedMatrix.values.toIntArray())
        ConnectionService.sendRequest(command: command)
        Haptic.feedback(.selection)
        return selectedMatrix
    }
}
