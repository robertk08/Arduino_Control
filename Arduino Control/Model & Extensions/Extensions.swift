//
//  Extensions.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import Foundation

extension UserDefaults {
    func save<T: Codable>(_ objects: [T], forKey key: String) {
        if let encoded = try? JSONEncoder().encode(objects) {
            set(encoded, forKey: key)
        }
    }
    func load<T: Codable>(forKey key: String) -> [T] {
        guard let data = data(forKey: key),
              let decoded = try? JSONDecoder().decode([T].self, from: data) else {
            return []
        }
        return decoded
    }
}

extension Array where Element == [Bool] {
    func toIntArray() -> [[Int]] {
        map { $0.map { $0 ? 1 : 0 } }
    }
}
