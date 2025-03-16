//
//  LedMatrix.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct LedMatrix: View {
    @State private var isOn = true
    let rows = 5
    let columns = 10
    @State private var isOnArray: [[Bool]]

    init() {
        _isOnArray = State(initialValue: Array(repeating: Array(repeating: false, count: columns), count: rows))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Led mode:")
                        .font(.title3)
                        .padding(.horizontal)
                    
                    ZStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.secondary)
                                .frame(width: 50, height: 50)
                                .padding(10)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        isOn = false
                                    }
                                }
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.cyan)
                                .frame(width: 50, height: 50)
                                .padding(10)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        isOn = true
                                    }
                                }
                        }
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, lineWidth: 4)
                            .frame(width: 50, height: 50)
                            .offset(x: isOn ? 40 : -40)
                    }
                    .frame(width: geometry.size.width / 2)
                }

                let cellSize = (geometry.size.width - CGFloat(columns) * 10) / CGFloat(columns) - 10 / CGFloat(columns)

                VStack(spacing: 10) {
                    ForEach(0..<rows, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<columns, id: \.self) { col in
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(isOnArray[row][col] ? Color.cyan : Color.secondary)
                                    .frame(width: cellSize, height: cellSize)
                            }
                        }
                    }
                }
                .padding(.leading, 10)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            updateLedState(at: value.location, in: geometry.size)
                        }
                        .onEnded { value in
                            updateLedState(at: value.location, in: geometry.size)
                        }
                )
            }
        }
    }

    /// Updates the LED state based on touch location
    private func updateLedState(at location: CGPoint, in size: CGSize) {
        let cellSize = (size.width - CGFloat(columns) * 10) / CGFloat(columns) - 10 / CGFloat(columns) + 10
        let x = Int((location.x - 10) / cellSize)
        let y = Int(location.y / cellSize)

        if (0..<columns).contains(x), (0..<rows).contains(y) {
            DispatchQueue.main.async {
                isOnArray[y][x] = isOn
            }
        }
    }
}

#Preview {
    LedMatrix()
}
