//
//  MatrixOverviewView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixOverviewView: View {
    @StateObject private var viewModel = MatrixOverviewViewModel()
    @Binding var selectedMatrix: Matrix
    @ObservedObject var storage = MatrixStorage.shared
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach($storage.matrixes.indices, id: \.self) { index in
                    GroupBox {
                        MatrixView(matrix: $storage.matrixes[index])
                            .frame(width: 150, height: 135)
                            .overlay {
                                if index == selectedMatrix.index {
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color.accentColor, lineWidth: 4)
                                        .foregroundStyle(Color.accentColor)
                                        .frame(width: 180, height: 165)
                                }
                            }
                    }
                    .contextMenu {
                        Button("Delete") {
                            Haptic.feedback(.success)
                            storage.matrixes.remove(at: index)
                        }
                    }
                    .onTapGesture {
                        selectedMatrix = storage.matrixes[index]
                        selectedMatrix.index = index
                        Haptic.feedback(.selection)
                    }
                    .padding(10)

                }
                GroupBox {
                    Button(action: {
                        viewModel.showListView = true
                    }, label: {
                        VStack {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                        }
                        .frame(width: 120, height: 120)
                    })
                    .tint(.accentColor)
                    .buttonStyle(.bordered)
                    .frame(width: 150, height: 135)
                }
                .padding(10)
            }
            .sheet(isPresented: $viewModel.showListView) {
                MatrixListView()
            }
            .onChange(of: selectedMatrix) { _,_ in
                viewModel.updateSelectedMatrix(selectedMatrix)
            }
        }
    }
}

#Preview {
    MatrixOverviewView(selectedMatrix: .constant(Matrix(id: UUID(), name: "Test", index: 0, values: [])))
}
