//
//  2DPoint.swift
//  Arduino Control
//
//  Created by Robert Krause on 10.06.25.
//

import Foundation

struct Point2D: Codable, Equatable {
    let x: Double
    let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    init(point: CGPoint) {
        self.x = point.x
        self.y = point.y
    }
    
    func distance(to other: Point2D) -> Double {
        let dx = x - other.x
        let dy = y - other.y
        return sqrt(dx * dx + dy * dy)
    }
}
