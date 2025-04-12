//
//  InverseKinematicsView.swift
//  Arduino Control
//
//  Created by Robert Krause on 10.04.25.
//

import SwiftUI

struct InverseKinematicsView: View {
    @StateObject private var viewModel = InverseKinematicsViewModel()
    @GestureState private var isDragging = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let angles = viewModel.calculateAngles()
                let positions = viewModel.calculatePostions(angles, geometry)
                ZStack {
                    ForEach(0..<3) { i in
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.accentColor.opacity(1 / (Double(i) / 0.7)))
                            .frame(width: 40, height: viewModel.lengths[i])
                            .rotationEffect(Angle(degrees: angles[i]), anchor: .bottom)
                            .position(positions[i])
                    }
                    Circle()
                        .frame(width: 15)
                        .scaleEffect(isDragging ? 1.75 : 1)
                        .animation(.spring(response: 0.5, dampingFraction: 0.4), value: isDragging)
                        .position(x: viewModel.position.x + geometry.size.width / 2, y: geometry.size.height - viewModel.position.y)
                        .onAppear {
                            print(geometry.size)
                            viewModel.position = CGPoint(x: 0, y:  (viewModel.lengths[0] + viewModel.lengths[1] + viewModel.lengths[2]))
                        }
                }
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .updating($isDragging) { _, state, _ in
                            state = true
                        }
                        .onChanged { value in
                            withAnimation(.linear(duration: 0.1)) {
                                viewModel.position = CGPoint(x: value.location.x - geometry.size.width / 2, y: geometry.size.height - value.location.y)
                            }
                            print("Tapped at: \( value.location.x - geometry.size.width / 2)" + " and: \( geometry.size.height - value.location.y)")
                        }
                        .onEnded { value in
                            Haptic.feedback(.rigid)
                        }
                )
            }
            GroupBox {
                ForEach(0..<3) { i in
                    Text("Angle \(i+1): \(Int(viewModel.angles[i]))°")
                    Slider(value: $viewModel.angles[i], in: 0...180, step: 1)
                }
            }
            .padding()
        }
    }
}

#Preview {
    InverseKinematicsView()
}
