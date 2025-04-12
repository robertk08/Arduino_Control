//
//  StepperMotorView.swift
//  Arduino Control
//
//  Created by Robert Krause on 11.04.25.
//

import SwiftUI

struct StepperMotorView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    TiltRectangleView(roll: $viewModel.speed)
                        .clipShape(Circle())
                        .frame(width: viewModel.baseSize, height: viewModel.baseSize)
                    
                    Circle()
                        .fill(Color.accentColor.opacity(0.25))
                        .frame(width: viewModel.baseSize, height: viewModel.baseSize)
                    
                    Circle()
                        .fill(Color.primary)
                        .frame(width: viewModel.stickSize, height: viewModel.stickSize)
                        .offset(viewModel.stickPosition)
                }
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            viewModel.updateDrag(value: value, size: geometry.size)
                        }
                        .onEnded { _ in
                            Haptic.feedback(.light)
                        }
                )
                Stepper(value: $viewModel.speed, in: -5...5) {
                    Text("\(viewModel.speed)")
                }
            }
            .onAppear {
                viewModel.start(size: geometry.size)
            }
        }
    }
}

#Preview {
    StepperMotorView()
}
