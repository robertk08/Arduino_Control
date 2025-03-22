//
//  EditMatrixView.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct EditMatrixView: View {
    @StateObject private var viewModel = EditMatrixViewModel()
    @Binding var selectedMatrix: Matrix
    @State private var cellSize: CGFloat = 0
    private var rows: Int { selectedMatrix.values.count }
    private var columns: Int { selectedMatrix.values.first?.count ?? 0 }
    
    var body: some View {
        GroupBox {
            GeometryReader { geometry in
                VStack {
                    selection
                    VStack(spacing: 5) {
                        ForEach(0..<rows, id: \.self) { row in
                            HStack(spacing: 5) {
                                ForEach(0..<columns, id: \.self) { col in
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(selectedMatrix.values[row][col] ? Color.accentColor : Color.primary)
                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                selectedMatrix = viewModel.updateLedState(selectedMatrix, value.location, cellSize + 5, columns, rows)
                            }
                    )
                }
                .onAppear {
                    cellSize = (geometry.size.width - CGFloat(columns) * 5) / CGFloat(columns)
                }
            }
        }
        .frame(height: 330)
        .padding(10)
    }
    
    var selection: some View {
        GroupBox {
            HStack {
                Text("Led mode:")
                    .font(.title3)
                    .padding(.horizontal)
                Picker("Mode", selection: $viewModel.isOn) {
                    Text("⬜️").tag(false)
                    Text("🟪").tag(true)
                }
                .pickerStyle(.segmented)
            }
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    EditMatrixView(selectedMatrix: .constant(MatrixStorage.shared.matrixes[0]))
}
