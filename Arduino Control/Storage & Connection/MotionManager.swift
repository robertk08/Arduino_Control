//
//  MotionManager.swift
//  Arduino Control
//
//  Created by Robert Krause on 12.04.25.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    private var motion = CMMotionManager()
    @Published var roll: Double = 0.0
    @Published var pitch: Double = 0.0
    @Published var yaw: Double = 0.0
    
    init() {
        startMotionUpdates()
    }
    
    private func startMotionUpdates() {
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 1.0 / 60.0
            motion.startDeviceMotionUpdates(to: .main) { data, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.roll = data.attitude.roll
                        self.pitch = data.attitude.pitch
                        self.yaw = data.attitude.yaw
                    }
                }
            }
        }
    }
}
