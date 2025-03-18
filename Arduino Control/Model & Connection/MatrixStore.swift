//
//  MatrixStore.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import Foundation

class MatrixStore: ObservableObject {
    @Published var matrices: [Matrix] {
        didSet {
            save()
        }
    }

    init() {
        let storedMatrices = UserDefaults.standard.load()
        if storedMatrices.isEmpty {
            matrices = [Matrix(id: UUID(), name: "Scene 1", values: Array(repeating: Array(repeating: false, count: 10), count: 5))]
            save()
        } else {
            matrices = storedMatrices
        }
    }

    private func save() {
        UserDefaults.standard.save(matrices)
    }
}
