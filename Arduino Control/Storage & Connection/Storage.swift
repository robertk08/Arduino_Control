//
//  Storage.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import Foundation

class MatrixStorage: ObservableObject {
    static let shared = MatrixStorage()
    @Published var matrixes: [Matrix] { didSet { save() } }

    init() {
        matrixes = UserDefaults.standard.load(forKey: "matrixes")
        if matrixes.isEmpty {
            matrixes = [Matrix(id: UUID(), name: "Scene 1", values: Array(repeating: Array(repeating: false, count: 12), count: 8))]
            save()
        }
    }

    private func save() {
        UserDefaults.standard.save(matrixes, forKey: "matrixes")
    }
}

class AnimationStorage: ObservableObject {
    static let shared = AnimationStorage()
    @Published var animations: [Animation] { didSet { save() } }
    @Published var emthyMatrix: Matrix = Matrix(id: UUID(), name: "", values: Array(repeating: Array(repeating: false, count: 12), count: 8))

    init() {
        animations = UserDefaults.standard.load(forKey: "animations")
    }

    private func save() {
        UserDefaults.standard.save(animations, forKey: "animations")

    }
}
