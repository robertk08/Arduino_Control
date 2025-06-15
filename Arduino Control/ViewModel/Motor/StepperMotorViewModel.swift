//
//  StepperMotorViewModel.swift
//  Movement
//
//  Created by Robert Krause on 22.02.25.
//

import Foundation
import SwiftUI

class StepperMotorViewModel: ObservableObject {
    @Published var baseSize = 0.0
    @Published var stickSize = 0.0
    @Published var angle: Double = 0
    @Published var speed: Double = 0
    @Published var stickPosition = CGSize.zero
    private var speedTimer: Timer? = nil
    private var sendCommandTimer: Timer? = nil
    private var radius: Double = 0

    func start(size: CGSize) {
        baseSize = size.width
        stickSize = baseSize / 4
        stickPosition.height = -baseSize / 2 + stickSize / 2
        radius = (baseSize - stickSize) / 2
        setSpeed()
    }
    
    func updateDrag(value: DragGesture.Value, size: CGSize) {
        let height = value.location.y - baseSize / 2
        let width = value.location.x - baseSize / 2
        angle = atan2(height, width)
        updatePosition()
    }
    
    func setSpeed() {
        speedTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.angle += self.speed / 10
            self.updatePosition()
        }
    }
    
    private func updatePosition() {
        stickPosition = CGSize(width: radius * cos(angle), height: radius * sin(angle))
    }
    
    func sentCommand() {
        sendCommandTimer?.invalidate()
        sendCommandTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {  _ in
            let command = ControlCommand(device: "Stepper", action: Int(self.angle) % 360)
            ConnectionService.sendRequest(command: command)
            Haptic.feedback(.selection)
            self.sendCommandTimer = nil
        }
    }
}
