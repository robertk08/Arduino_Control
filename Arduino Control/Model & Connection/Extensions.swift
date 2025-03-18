//
//  Extensions.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import Foundation

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
