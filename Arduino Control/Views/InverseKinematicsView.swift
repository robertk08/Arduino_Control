//
//  InverseKinematicsView.swift
//  Arduino Control
//
//  Created by Robert Krause on 10.04.25.
//

import SwiftUI

struct InverseKinematicsView: View {
    @StateObject private var viewModel = InverseKinematicsViewModel()
    
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
                }
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
