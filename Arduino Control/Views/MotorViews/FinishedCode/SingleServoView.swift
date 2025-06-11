//
//  SingleServoView.swift
//  Arduino Control
//
//  Created by Robert Krause on 02.04.25.
//

import SwiftUI

struct SingleServoView: View {
    @StateObject private var viewModel = SingleServoViewModel()
    @Binding var position: ServoPosition
    
    var body: some View {
        GroupBox {
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(style: StrokeStyle(lineWidth: 35, lineCap: .round))
                    .rotationEffect(.degrees(180))
                    .scaledToFill()
                    .padding(.horizontal)
                    .offset(y: 80)
                    .foregroundColor(.accentColor)
                    .background(
                        GeometryReader { innerGeometry in
                            Color.clear
                                .onAppear {
                                    let width = innerGeometry.size.width
                                    viewModel.circleRadius = width / 2 - 17.5
                                }
                                .onChange(of: innerGeometry.size) { _, newSize in
                                    viewModel.circleRadius = newSize.width / 2 - 17.5
                                }
                        }
                    )
                    .animation(.easeInOut(duration: 0.2), value: position.current)
                
                Circle()
                    .frame(width: 35)
                    .foregroundStyle(.primary)
                    .offset(
                        x: cos(Angle(degrees: Double(position.current)).radians) * -viewModel.circleRadius,
                        y: sin(Angle(degrees: -Double(position.current)).radians) * viewModel.circleRadius + 80)
                
                VStack {
                    Text(String(position.id + 1))
                    TextField("Enter Position", value: $position.current, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .onSubmit {
                            if position.current < 0 {
                                position.current = 0
                            } else if position.current > 180 {
                                position.current = 180
                            }
                            position.last = position.current
                            viewModel.sendCommand(position)
                        }
                        .multilineTextAlignment(.center)
                }
                .font(.title)
                .bold()
            }
            .frame(height: 200)
        }
        .contentShape(Rectangle())
        .simultaneousGesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 3)
            .onChanged { value in
                viewModel.updateServo(&position, width: value.translation.width)
            }
            .onEnded { _ in
                position.last = position.current
            }
    }
}


#Preview {
    SingleServoView(position: .constant(ServoPosition()))
}
