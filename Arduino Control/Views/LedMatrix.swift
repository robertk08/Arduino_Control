//
//  LedMatrix.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct LedMatrix: View {
    @State private var isOn = true
    @State var rows: Int
    @State var columns: Int
    @Binding var matrix: Matrix
    
    init(matrix: Binding<Matrix>) {
        self._matrix = matrix
        self._rows = State(initialValue: matrix.values.wrappedValue.count)
        self._columns = State(initialValue: matrix.values.wrappedValue.first?.count ?? 0)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                GroupBox {
                    HStack {
                        Text("Led mode:")
                            .font(.title3)
                            .padding(.horizontal)
                        
                        ZStack {
                            HStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.secondary)
                                    .frame(width: 50, height: 50)
                                    .padding(.horizontal, 10)
                                    .onTapGesture {
                                        withAnimation(.snappy) {
                                            isOn = false
                                        }
                                    }
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.accentColor)
                                    .frame(width: 50, height: 50)
                                    .padding(.horizontal, 10)
                                    .onTapGesture {
                                        withAnimation(.snappy) {
                                            isOn = true
                                        }
                                    }
                            }
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.primary, lineWidth: 4)
                                .frame(width: 50, height: 50)
                                .offset(x: isOn ? 40 : -40)
                        }
                        .frame(width: geometry.size.width / 2)
                    }
                }
                .padding(.vertical, 10)

                let cellSize = (geometry.size.width - CGFloat(columns) * 10) / CGFloat(columns)
                
                VStack(spacing: 10) {
                    ForEach(0..<rows, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<columns, id: \.self) { col in
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(matrix.values[row][col] ? Color.accentColor : Color.secondary)
                                    .frame(width: cellSize, height: cellSize)
                            }
                        }
                    }
                }
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
                matrix.values[y][x] = isOn
            }
        }
    }
}

#Preview {
    //LedMatrix()
}
