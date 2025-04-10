//
//  SingleServoViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 02.04.25.
//

import Foundation

class SingleServoViewModel: ObservableObject {
    @Published var sendCommandTimer: Timer? = nil
    @Published var circleRadius: CGFloat = 0
    
    func updateServo(_ position: inout ServoPosition, width: CGFloat) {
        let updatedPosition = position
        position.current = Int(min(max(0.0, Double(position.last) + width / 1.6), 180.0))
        
        sendCommandTimer?.invalidate()
        sendCommandTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {  _ in
            self.sendCommand(updatedPosition)
            Haptic.feedback(.selection)
            self.sendCommandTimer = nil
        }
    }
    
    func sendCommand(_ position: ServoPosition) {
        let command = ControlCommand(device: "Servo", action: 0, values: [[position.id, position.current]])
        ConnectionService.sendRequest(command: command)
    }
}
