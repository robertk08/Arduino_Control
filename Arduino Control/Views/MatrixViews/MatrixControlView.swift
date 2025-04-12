//
//  MatrixControlView.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import SwiftUI

struct MatrixControlView: View {
    @State var selectedMatrix = MatrixStorage.shared.matrixes.first!
    
    var body: some View {
        VStack {
            EditMatrixView(selectedMatrix: $selectedMatrix)
            Divider()
            MatrixOverviewView(selectedMatrix: $selectedMatrix)
        }
        .toolbar { toolbarContent }
        .onAppear { selectedMatrix.index = 0 }
    }
    
    var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Haptic.feedback(.success)
                    MatrixStorage.shared.matrixes.append(
                        Matrix(id: UUID(), name: "Scene \(MatrixStorage.shared.matrixes.count + 1)", values: selectedMatrix.values))
                    selectedMatrix.index = MatrixStorage.shared.matrixes.count - 1
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(.bordered)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Haptic.feedback(.success)
                    MatrixStorage.shared.matrixes[selectedMatrix.index ?? 0] = selectedMatrix
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
