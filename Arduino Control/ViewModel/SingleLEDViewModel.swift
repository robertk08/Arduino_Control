//
//  SingleLEDViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation
import SwiftUI

class SingleLEDViewModel: ObservableObject {
    @AppStorage("arduinoIP") var arduinoIP = "192.168.4.1"
    @Published var isOn = false
    @Published var onDuration: Double = 1.0
    @Published var offDuration: Double = 1.0
    private var blinkTimer: Timer?
    var isBlinking: Bool { blinkTimer != nil }
  
    func blink() {
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
}
