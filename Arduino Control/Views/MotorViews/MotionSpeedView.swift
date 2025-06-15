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
    let isHorizontal: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let diagonale = sqrt(pow(geometry.size.width, 2) + pow(geometry.size.height, 2))
            let height: CGFloat = geometry.size.height * 2

            let cx = geometry.size.width / 2 - height / 2 * sin(isHorizontal ? motionManager.pitch : motionManager.roll)
            let cy = geometry.size.height / 2 + height / 2 * cos(isHorizontal ? motionManager.pitch : motionManager.roll)
            
            Rectangle()
                .frame(width: diagonale, height: height)
                .rotationEffect(.radians(isHorizontal ? motionManager.pitch : motionManager.roll))
                .position(x: cx, y: cy)
                .foregroundStyle(Color.accentColor)
        }
        .onReceive(isHorizontal ? motionManager.$pitch : motionManager.$roll) { newValue in
            if newValue > 0 {
                let adjusted = newValue - 0.5
                speed = adjusted < 0 ? 0 : adjusted * (isHorizontal ? 5 : 3)
            } else if newValue < 0 {
                let adjusted = newValue + 0.5
                speed = adjusted > 0 ? 0 : adjusted * (isHorizontal ? 5 : 3)
            }
        }
    }
}

#Preview {
    MotionSpeedView(speed: .constant(0), isHorizontal: false)
}
