//
//  AngleConfiguration.swift
//  Arduino Control
//
//  Created by Robert Krause on 10.06.25.
//

import Foundation

struct AngleConfiguration: Codable, Equatable {
    let winkel1: Double
    let winkel2: Double
    let winkel3: Double
    let endPosition: Point2D
    let totalMovement: Double
    
    init(winkel1: Double = 90, winkel2: Double = 90, winkel3: Double = 90, endPosition: Point2D = Point2D(x: 0, y: 250), oldConfiguration: AngleConfiguration? = nil) {
        self.winkel1 = winkel1
        self.winkel2 = winkel2
        self.winkel3 = winkel3
        self.endPosition = endPosition
        if let old = oldConfiguration {
            self.totalMovement = abs(winkel1 - old.winkel1) + abs(winkel2 - old.winkel2) + abs(winkel3 - old.winkel3)
        } else {
            self.totalMovement = 0.0
        }
    }
    
    func returnAngles() -> [Double]{
        return [winkel1, winkel2, winkel3]
    }
}
