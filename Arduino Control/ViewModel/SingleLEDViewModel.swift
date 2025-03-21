//
//  SingleLEDViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation
import SwiftUI

class SingleLEDViewModel: ObservableObject {
    @Published var isOn = false
    @Published var onDuration: Double = 1.0
    @Published var offDuration: Double = 1.0
    private var blinkTimer: Timer?
    var isBlinking: Bool { blinkTimer != nil }
  
    func blink() {
        Haptic.feedback(.success)
        if blinkTimer != nil {
            blinkTimer?.invalidate()
            blinkTimer = nil
            isOn = false
        } else {
            isOn = true
            scheduleNextBlink(after: onDuration)
        }
    }
    
    private func scheduleNextBlink(after delay: TimeInterval) {
        blinkTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            withAnimation {
                self.isOn.toggle()
            }
            let nextDelay = self.isOn ? self.onDuration : self.offDuration
            self.scheduleNextBlink(after: nextDelay)
        }
    }
    
    deinit {
        blinkTimer?.invalidate()
    }
    
    func updateLED() {
        Haptic.feedback(.selection)
        let command = ControlCommand(device: "LED", action: isOn ? 1 : 0)
        ConnectionService.sendRequest(command: command)
    }
}
