//
//  AngleConfiguration.swift
//  Arduino Control
//
//  Created by Robert Krause on 10.06.25.
//

import Foundation

struct AngleConfiguration: Codable, Equatable {
    let angle1: Double
    let angle2: Double
    let angle3: Double
    let endPosition: Point2D
    let totalMovement: Double
    
    init(angle1: Double = 90, angle2: Double = 90, angle3: Double = 90, endPosition: Point2D = Point2D(x: 0, y: 250), oldConfiguration: AngleConfiguration? = nil) {
        self.angle1 = angle1
        self.angle2 = angle2
        self.angle3 = angle3
        self.endPosition = endPosition
        if let old = oldConfiguration {
            self.totalMovement = abs(angle1 - old.angle1) + abs(angle2 - old.angle2) + abs(angle3 - old.angle3)
        } else {
            self.totalMovement = 0.0
        }
    }
    
    func returnAngles() -> [Double]{
        return [angle1, angle2, angle3]
    }
}
