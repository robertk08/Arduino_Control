//
//  Matix.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import Foundation

struct Matrix: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var index: Int?
    var values: [[Bool]]
    
    init(id: UUID = UUID(), name: String = "", index: Int? = nil, values: [[Bool]] = Array(repeating: Array(repeating: false, count: 12), count: 8)) {
        self.id = id
        self.name = name
        self.index = index
        self.values = values
    }
}
