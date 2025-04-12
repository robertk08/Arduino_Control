//
//  ServoPosition.swift
//  Arduino Control
//
//  Created by Robert Krause on 02.04.25.
//

import Foundation

struct ServoPosition: Identifiable, Codable, Equatable {
    var id: Int
    var current: Int
    var last: Int
    
    init(id: Int = 0, current: Int = 0, last: Int = 0) {
        self.id = id
        self.current = current
        self.last = last
    }
}
