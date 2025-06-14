//
//  StepperMotorView.swift
//  Arduino Control
//
//  Created by Robert Krause on 11.04.25.
//

import SwiftUI

struct StepperMotorView: View {
    @StateObject private var viewModel = StepperMotorViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                MotionSpeedView(speed: $viewModel.speed)
                    .clipShape(Circle())
                    .frame(width: viewModel.baseSize, height: viewModel.baseSize)
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 4)
                            .shadow(color: .black.opacity(0.3), radius: 7)
                            .scaleEffect(1.01)
                    )
                
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: viewModel.stickSize, height: viewModel.stickSize)
                    .offset(viewModel.stickPosition)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
                    .animation(.easeInOut(duration: 0.25), value: viewModel.angle)
            }
            .contentShape(Rectangle())
            .onAppear { viewModel.start(size: geometry.size) }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        viewModel.updateDrag(value: value, size: geometry.size)
                    }
                    .onEnded { _ in
                        Haptic.feedback(.light)
                    }
            )
        }
    }
}

#Preview {
    StepperMotorView()
}
