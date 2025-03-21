//
//  SelectMatrixView.swift
//  Arduino Control
//
//  Created by Robert Krause on 20.03.25.
//

import SwiftUI

struct SelectMatrixView: View {
    @Binding var matrixes: [Matrix]
    let columns: [GridItem] = [
            GridItem(.adaptive(minimum: 150))
        ]
    var body: some View {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(MatrixStorage.shared.matrixes.indices, id: \.self) { index in
                    let active = matrixes.contains(MatrixStorage.shared.matrixes[index])
//                    MatrixView(index: index, editable: false)
//                        .grayscale(active ? 0 : 0.7)
//                        .padding(.horizontal, 10)
//                        .padding(.vertical)
//                        .frame(height: 165)
//                        .background(
//                            RoundedRectangle(cornerRadius: 12)
//                                .fill(Color(.systemGray6))
//                                .frame(width: 180)
//                        )
//                        .overlay(
//                            Image(systemName: active ? "checkmark.circle.fill" : "circle")
//                                .foregroundStyle(active ? Color.accentColor : .primary)
//                                .font(.title)
//                                .offset(x: 20, y: -5),
//                            alignment: .bottomLeading
//                        )
//                        .onTapGesture {
//                            Haptic.feedback(.selection)
//                            if active {
//                                matrixes.removeAll { $0 == MatrixStorage.shared.matrixes[index] }
//                            } else {
//                                matrixes.append(MatrixStorage.shared.matrixes[index])
//                            }
//                        }
                }
            }
            .padding(.horizontal)
    }
}

#Preview {
    SelectMatrixView(matrixes: .constant(MatrixStorage.shared.matrixes))
}
