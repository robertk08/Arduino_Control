//
//  Animation.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation

struct Animation: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var delay: TimeInterval
    var repeating: Bool
    var matrixes: [Matrix]
    
    init(id: UUID = UUID(), name: String = "", delay: TimeInterval = 1, repeating: Bool = false, matrixes: [Matrix] = []) {
        self.id = id
        self.name = name
        self.delay = delay
        self.repeating = repeating
        self.matrixes = matrixes
    }
}
