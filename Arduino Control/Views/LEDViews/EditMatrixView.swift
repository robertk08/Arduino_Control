//
//  EditMatrixView.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct EditMatrixView: View {
    @StateObject private var viewModel = EditMatrixViewModel()
    @State var rows: Int
    @State var columns: Int
    @Binding var selectedMatrix: Matrix
    
    init(selectedMatrix: Binding<Matrix>) {
        self._selectedMatrix = selectedMatrix
        self._rows = State(initialValue: selectedMatrix.values.wrappedValue.count)
        self._columns = State(initialValue: selectedMatrix.values.wrappedValue.first?.count ?? 0)
    }
    
    var body: some View {
        GroupBox {
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
                                        .frame(width: 30, height: 30)
                                        .padding(.horizontal, 10)
                                        .onTapGesture {
                                            withAnimation(.snappy) {
                                                viewModel.isOn = false
                                            }
                                        }
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.accentColor)
                                        .frame(width: 30, height: 30)
                                        .padding(.horizontal, 10)
                                        .onTapGesture {
                                            withAnimation(.snappy) {
                                                viewModel.isOn = true
                                            }
                                        }
                                }
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.primary, lineWidth: 4)
                                    .frame(width: 30, height: 30)
                                    .offset(x: viewModel.isOn ? 30 : -30)
                            }
                            .frame(width: geometry.size.width / 2)
                        }
                    }
                    .padding(.bottom, 10)
                    
                    let cellSize = (geometry.size.width - CGFloat(columns) * 5) / CGFloat(columns)
                    
                    VStack(spacing: 5) {
                        ForEach(0..<rows, id: \.self) { row in
                            HStack(spacing: 5) {
                                ForEach(0..<columns, id: \.self) { col in
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(selectedMatrix.values[row][col] ? Color.accentColor : Color.secondary)
                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                selectedMatrix = viewModel.updateLedState(selectedMatrix: selectedMatrix, at: value.location, in: geometry.size, columns: columns, rows: rows)
                            }
                            .onEnded { value in
                                selectedMatrix = viewModel.updateLedState(selectedMatrix: selectedMatrix, at: value.location, in: geometry.size, columns: columns, rows: rows)
                            }
                    )
                }
            }
            .frame(height: 310)
        }
        .padding(10)
    }
}

#Preview {
    EditMatrixView(selectedMatrix: .constant(MatrixStorage.shared.matrixes[0]))
}
