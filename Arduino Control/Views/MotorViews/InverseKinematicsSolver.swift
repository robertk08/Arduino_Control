//
//  InverseKinematicsSolver.swift
//  Arduino Control
//
//  Created by Robert Krause on 10.06.25.
//

import Foundation
import SwiftUI

class InverseKinematicsSolver: ObservableObject {
    @AppStorage("angleResolution") var angleResolution: Double = 3.0
    @AppStorage("positionTolerance") var positionTolerance: Double = 10.0
    @Published var currentConfiguration = AngleConfiguration()
    let lenght1: Double = 100
    let lenght2: Double = 50
    let lenght3: Double = 100
    
    func findOptimalSolution(point: Point2D) -> AngleConfiguration {
        let solutions = solve1(point)
        
        if solutions.isEmpty {
            print("❌ Keine Lösung gefunden!")
            Haptic.feedback(.error)
        }
        
        let optimalSolution = solutions.min { $0.totalMovement < $1.totalMovement }
        currentConfiguration = optimalSolution ?? currentConfiguration
        return currentConfiguration
    }
    
    
    
    func solve1(_ target: Point2D) -> [AngleConfiguration] {
        var validConfigurations: [AngleConfiguration] = []
        
       if let solution = checkRange(target) {
            return solution
        }
        
        // Brute-Force Suche durch alle Winkelkombinationen
        let angleRange = stride(from: 0, through: 180.0, by: angleResolution)
        var totalCombinations = 0
        var validSolutions = 0
        
        for theta1 in angleRange {
            for theta2 in angleRange {
                for theta3 in angleRange {
                    totalCombinations += 1
                    
                    let endPosition = forwardKinematics(winkel1: theta1, winkel2: theta2, winkel3: theta3)
                    let distance = endPosition.distance(to: target)
                    
                    if distance <= positionTolerance {
                        let config = AngleConfiguration(
                            winkel1: theta1,
                            winkel2: theta2,
                            winkel3: theta3,
                            endPosition: endPosition,
                            oldConfiguration: currentConfiguration
                        )
                        validConfigurations.append(config)
                        validSolutions += 1
                    }
                }
            }
        }
        
        print("Getestete Kombinationen: \(totalCombinations)")
        print("Gefundene Lösungen: \(validSolutions)")
        
        return validConfigurations
    }
    
    func solve2(_ target: Point2D) -> [AngleConfiguration] {
        var validConfigurations: [AngleConfiguration] = []
        
       if let solution = checkRange(target) {
            return solution
        }
        
        // Brute-Force Suche durch alle Winkelkombinationen
        let angleRange = stride(from: 0, through: 180.0, by: angleResolution)
        var totalCombinations = 0
        var validSolutions = 0
        
        for theta1 in angleRange {
            for theta2 in angleRange {
                for theta3 in angleRange {
                    totalCombinations += 1
                    
                    let endPosition = forwardKinematics(winkel1: theta1, winkel2: theta2, winkel3: theta3)
                    let distance = endPosition.distance(to: target)
                    
                    if distance <= positionTolerance {
                        let config = AngleConfiguration(
                            winkel1: theta1,
                            winkel2: theta2,
                            winkel3: theta3,
                            endPosition: endPosition,
                            oldConfiguration: currentConfiguration
                        )
                        validConfigurations.append(config)
                        validSolutions += 1
                    }
                }
            }
        }
        
        print("Getestete Kombinationen: \(totalCombinations)")
        print("Gefundene Lösungen: \(validSolutions)")
        
        return validConfigurations
    }
    
    func checkRange(_ target: Point2D) -> [AngleConfiguration]? {
        let targetDistance = sqrt(target.x * target.x + target.y * target.y)
        let maxReach = lenght1 + lenght2 + lenght3
        let minReach = abs(abs(lenght1 - lenght2) - lenght3)
        
        var m = target.x / target.y
        var angle = atan(m)
        angle *= 180 / .pi
        angle += 90
        
        if targetDistance > maxReach {
            print("⚠️ Ziel außerhalb der Reichweite!")
            return [AngleConfiguration(winkel1: angle, oldConfiguration: currentConfiguration)]
        } else if targetDistance < minReach {
            print("⚠️ Ziel außerhalb der Reichweite!")
            angle /= 2
            angle += m > 0 ? 0 : 90
            return [AngleConfiguration(winkel1: angle, winkel2: m > 0 ? 180 : 0, winkel3: m > 0 ? 180 : 0, oldConfiguration: currentConfiguration)]
        }
        return nil
    }
    
    func forwardKinematics(winkel1: Double, winkel2: Double, winkel3: Double) -> Point2D {
        var t1 = winkel1
        var t2 = winkel2 + winkel1  - 90
        var t3 = winkel3 + t2       - 90
        
        t1 *= .pi / 180.0
        t2 *= .pi / 180.0
        t3 *= .pi / 180.0
        
        let x = -(lenght1 * cos(t1) + lenght2 * cos(t2) + lenght3 * cos(t3))
        let y = lenght1 * sin(t1) + lenght2 * sin(t2) + lenght3 * sin(t3)
        return Point2D(x: x, y: y)
    }
    
    func printConfiguration(_ config: AngleConfiguration) {
        print("\n📐 Winkel-Konfiguration:")
        print("   θ1 (Basis): \(String(format: "%.1f", config.winkel1))°")
        print("   θ2 (Mitte): \(String(format: "%.1f", config.winkel2))°")
        print("   θ3 (Ende):  \(String(format: "%.1f", config.winkel3))°")
        print("   Position: (\(String(format: "%.2f", config.endPosition.x)), \(String(format: "%.2f", config.endPosition.y)))")
        print("   Bewegung: \(String(format: "%.1f", config.totalMovement))°")
    }
}
