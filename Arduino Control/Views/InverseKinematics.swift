//
//  InverseKinematics.swift
//  Arduino Control
//
//  Created by Robert Krause on 10.04.25.
//

import SwiftUI

struct InverseKinematics: View {
    @State private var angle1: Double = 90
    @State private var angle2: Double = 90
    @State private var angle3: Double = 90
    @State private var length1: Double = 100
    @State private var length2: Double = 50
    @State private var length3: Double = 100
    @State private var offsetX2: Double = 0
    @State private var offsetX3: Double = 0
    @State private var offsetY2: Double = 100
    @State private var offsetY3: Double = 50
    @State private var temp: Double = 0
    @State private var temp2: Double = 0


    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 10, height: length1)
                        .rotationEffect(Angle(degrees: angle1 - 90), anchor: .bottom)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 10, height: length2)
                        .rotationEffect(Angle(degrees: angle2 - 90), anchor: .bottom)
                        .position(x: geometry.size.width / 2 - offsetX2, y: (geometry.size.height / 2)  + length2 / 2 - offsetY2)

                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 10, height: length3)
                        .rotationEffect(Angle(degrees: angle3 - 90), anchor: .bottom)
                        .position(x: geometry.size.width / 2 - offsetX2 - offsetX3, y: (geometry.size.height / 2) - offsetY2 - offsetY3)

                    
                }
                .frame(height: 300)
            }
            .onChange(of: angle1) { _ , _ in
                let angleInRadians = angle1 * .pi / 180

                offsetX2 = length1 * cos(angleInRadians)
                offsetY2 = length1 * sin(angleInRadians)
                angle2 = temp + angle1
            }
            .onChange(of: angle2) { _ , _ in
                temp = angle2 - angle1
                let angleInRadians = angle2 * .pi / 180

                offsetX3 = length2 * cos(angleInRadians)
                offsetY3 = length2 * sin(angleInRadians)
                angle3 = temp2 + angle2
            }
            .onChange(of: angle3) { _ , _ in
                temp2 = angle3 - angle2
            }
            
            VStack(spacing: 20) {
                VStack {
                    Text("Angle 1: \(Int(angle1))°")
                    Slider(value: $angle1, in: 0...180, step: 1)
                }
                VStack {
                    Text("Angle 2: \(Int(angle2))°")
                    Slider(value: $angle2, in: 0...180, step: 1)
                }
                VStack {
                    Text("Angle 3: \(Int(angle3))°")
                    Slider(value: $angle3, in: 0...180, step: 1)
                }
            }
            .padding()
        }
    }
}

#Preview {
    InverseKinematics()
}
