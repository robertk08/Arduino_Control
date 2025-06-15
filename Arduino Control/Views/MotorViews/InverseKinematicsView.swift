//
//  InverseKinematicsView.swift
//  Arduino Control
//
//  Created by Robert Krause on 10.04.25.
//

import SwiftUI

struct InverseKinematicsView: View {
    @StateObject var viewModel = InverseKinematicsViewModel()
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    var isHorizontal = geometry.size.width - 50 > geometry.size.height
                    StepperMotorView(isHorizontal: isHorizontal)
                        .frame(width: 100, height: 100)
                        .position(x: 70, y: 70)
                        .zIndex(1)
                    armView
                    Spacer()
                }
            }
            manuellView
        }
    }
    
    var armView: some View {
        GeometryReader { geometry in
            ZStack {
                let angles = viewModel.calculateAngles()
                let positions = viewModel.calculatePositions(geometry)
                
                ForEach(0..<3) { i in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.accentColor.opacity(0.8))
                        .frame(width: 20, height: viewModel.lengths[i])
                        .rotationEffect(Angle(degrees: angles[i]), anchor: .bottom)
                        .position(positions[i])
                        .animation(.linear(duration: 0.3), value: angles[i])
                }
                
                Circle()
                    .frame(width: 20)
                    .position(x: viewModel.position.x + geometry.size.width / 2, y:  geometry.size.height - viewModel.position.y)
                    .onAppear {
                        viewModel.position = CGPoint(x: 0, y:  (viewModel.lengths[0] + viewModel.lengths[1] + viewModel.lengths[2]))
                    }
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        viewModel.position = CGPoint(x: value.location.x - geometry.size.width / 2, y: geometry.size.height - value.location.y)
                    }
                    .onEnded { value in
                        Haptic.feedback(.rigid)
                        viewModel.tryToSolve()
                    }
            )
        }
    }
    
    var manuellView: some View {
        GroupBox("Position manuell eingeben") {
            ForEach(0..<2) { i in
                HStack {
                    Text(i == 0 ? "X:" :"Y:")
                    TextField("Koordinate", value: i == 0 ? $viewModel.position.x :$viewModel.position.y, formatter: NumberFormatter())
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numbersAndPunctuation)
                        .onSubmit { viewModel.tryToSolve() }
                }
            }
            ForEach(0..<3) { i in
                HStack {
                    Text("\(i+1): \(Int(viewModel.angles[i]))°")
                    Slider(value: $viewModel.angles[i], in: 0...180, step: 1)
                }
            }
        }
        .padding()
    }
}

#Preview {
    InverseKinematicsView()
}
