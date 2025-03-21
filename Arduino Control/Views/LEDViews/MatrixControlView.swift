//
//  MatrixControlView.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import SwiftUI

struct MatrixControlView: View {
    @StateObject private var viewModel = MatrixControlViewModel()
    
    var body: some View {
        VStack {
            EditMatrixView(selectedMatrix: $viewModel.selectedMatrix)
            Divider()
            MatrixOverviewView(selectedMatrix: $viewModel.selectedMatrix)
        }
        .toolbar {
            toolbarContent
        }
        .onChange(of: viewModel.selectedMatrix) { _,_ in
            viewModel.updateSelectedMatrix()
        }
    }
    
    var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Haptic.feedback(.success)
                    MatrixStorage.shared.matrixes.append(
                        Matrix(id: UUID(), name: "Scene \(MatrixStorage.shared.matrixes.count + 1)", values: viewModel.selectedMatrix.values))
                    viewModel.selectedMatrix.index = MatrixStorage.shared.matrixes.count - 1
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(.bordered)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Haptic.feedback(.success)
                    MatrixStorage.shared.matrixes[viewModel.selectedMatrix.index ?? 0] = viewModel.selectedMatrix
                } label: {
                    Image(systemName: "pencil")
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    MatrixControlView()
}
