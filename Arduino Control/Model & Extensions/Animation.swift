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
}
