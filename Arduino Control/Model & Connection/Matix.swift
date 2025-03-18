//
//  Matix.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct Matrix: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var values: [[Bool]]
}

class MatrixStore: ObservableObject {
    @Published var matrices: [Matrix] {
        didSet {
            save()
        }
    }

    init() {
        self.matrices = UserDefaults.standard.load()
        if self.matrices.isEmpty {
            self.matrices = [Matrix(id: UUID(), name: "Scene 1", values: Array(repeating: Array(repeating: false, count: 10), count: 5))]
            save()
        }
    }

    private func save() {
        UserDefaults.standard.save(matrices)
    }
}

extension UserDefaults {
    private var key: String { "matrices" }
    
    func save(_ matrices: [Matrix]) {
        if let encoded = try? JSONEncoder().encode(matrices) {
            set(encoded, forKey: key)
        }
    }
    
    func load() -> [Matrix] {
        guard let data = data(forKey: key),
              let decoded = try? JSONDecoder().decode([Matrix].self, from: data) else {
            return []
        }
        return decoded
    }
}
