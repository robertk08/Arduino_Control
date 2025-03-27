//
//  SelectMatrixView.swift
//  Arduino Control
//
//  Created by Robert Krause on 20.03.25.
//

import SwiftUI

struct SelectMatrixView: View {
    @ObservedObject var storage = MatrixStorage.shared
    @Binding var matrixes: [Matrix]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 15) {
            ForEach($storage.matrixes, id: \.id) { $matrix in
                let active = matrixes.contains(matrix)
                Button {
                    Haptic.feedback(.selection)
                    if active {
                        matrixes.removeAll { $0 == matrix }
                    } else {
                        matrixes.append(matrix)
                    }
                } label: {
                    MatrixView(matrix: $matrix, nameEditable: false)
                        .padding(.top, 10)
                        .frame(height: 150)
                }
                .buttonStyle(.bordered)
                .tint(active ? .accentColor : .secondary)
                .padding(.horizontal, 3)
            }
        }
    }
}

#Preview {
    SelectMatrixView(matrixes: .constant(MatrixStorage.shared.matrixes))
}
