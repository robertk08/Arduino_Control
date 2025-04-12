//
//  ViewModel.swift
//  Movement
//
//  Created by Robert Krause on 22.02.25.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var baseSize: CGFloat = 50
    @Published var stickSize: CGFloat = 20
    @Published var stickPosition = CGSize.zero
    @Published var speed: Double = 0
    private var sendCommandTimer: Timer? = nil
    private var angle: Double = 0
    private var distance: Double = 0

    func start(size: CGSize) {
        baseSize = size.width
        stickSize = baseSize / 5
        stickPosition.height = -baseSize / 2 + stickSize / 2
        distance = (baseSize - stickSize) / 2
        setSpeed()
    }
    
    func updateDrag(value: DragGesture.Value, size: CGSize) {
        let height = value.location.y - baseSize / 2
        let width = value.location.x - baseSize / 2
        angle = atan2(height, width)
        withAnimation(.linear(duration: 0.25)) {
            stickPosition = CGSize(width: distance * cos(angle), height: distance * sin(angle))
        }
    }
    
    func setSpeed() {
        sendCommandTimer = Timer.scheduledTimer(withTimeInterval: 0.0001, repeats: true) { _ in
            self.angle += self.speed / 10000
            if self.angle > 360 {
                self.angle = 0
            }
            self.stickPosition = CGSize(width: self.distance * cos(self.angle), height: self.distance * sin(self.angle))
        }
    }
}
