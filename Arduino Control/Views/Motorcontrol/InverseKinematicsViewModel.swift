//
//  InverseKinematicsViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 10.04.25.
//

import Foundation
import SwiftUICore

class InverseKinematicsViewModel: ObservableObject {
    @Published var angles: [Double] = [90, 90, 90]
    @Published var lengths: [Double] = [200, 100, 200]
    @Published var position: CGPoint = .zero
    private var sendCommandTimer: Timer? = nil
    
    func sendCommand(values: [[Int]]) {
        let command = ControlCommand(device: "Servo", action: 0, values: values)
        ConnectionService.sendRequest(command: command)
    }
    
    func calculateAngles() -> [Double] {
        let angle1 = angles[0] - 90
        let angle2 = angle1 + angles[1] - 90
        let angle3 = angle2 + angles[2] - 90
        
        sendCommandTimer?.invalidate()
        sendCommandTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {  _ in
            self.sendCommand(values: [[0, Int(self.angles[0])], [1, Int(self.angles[1])], [2, Int(self.angles[2])]])
            self.sendCommandTimer = nil
        }
        return [angle1, angle2, angle3]
    }
    
    func calculatePostions(_ angles: [Double],_ geometry: GeometryProxy) -> [CGPoint] {
        let centerX = geometry.size.width / 2
        let centerY = geometry.size.height
        
        let x1 = lengths[0] * sin(Angle(degrees: angles[0]).radians)
        let y1 = -lengths[0] * cos(Angle(degrees: angles[0]).radians)
        let x2 = x1 + lengths[1] * sin(Angle(degrees: angles[1]).radians)
        let y2 = y1 + (-lengths[1] * cos(Angle(degrees: angles[1]).radians))
        return [CGPoint(x: centerX, y: centerY - lengths[0] / 2), CGPoint(x: centerX + x1, y: centerY + y1 - lengths[1] / 2), CGPoint(x: centerX + x2, y: centerY + y2 - lengths[2] / 2)]
    }
}
