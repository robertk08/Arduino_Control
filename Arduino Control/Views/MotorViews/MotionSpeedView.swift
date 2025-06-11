//
//  MotionSpeedView.swift
//  Arduino Control
//
//  Created by Robert Krause on 12.04.25.
//

import SwiftUI

struct MotionSpeedView: View {
    @StateObject private var motionManager = MotionManager()
    @Binding var speed: Double
    
    var body: some View {
        GeometryReader { geometry in
            let diagonale = sqrt(pow(geometry.size.width, 2) + pow(geometry.size.height, 2))
            let height: CGFloat = geometry.size.height * 2

            let cx = geometry.size.width / 2 - height / 2 * sin(motionManager.roll)
            let cy = geometry.size.height / 2 + height / 2 * cos(motionManager.roll)
            
            Rectangle()
                .opacity(0.6)
                .frame(width: diagonale, height: height)
                .rotationEffect(.radians(motionManager.roll))
                .position(x: cx, y: cy)
        }
        .onReceive(motionManager.$roll) { newValue in
            if newValue > 0 {
                let adjusted = newValue - 0.5
                speed = adjusted < 0 ? 0 : adjusted * 1.5
            } else if newValue < 0 {
                let adjusted = newValue + 0.5
                speed = adjusted > 0 ? 0 : adjusted * 1.5
            }
        }
    }
}

#Preview {
    MotionSpeedView(speed: .constant(0))
}
