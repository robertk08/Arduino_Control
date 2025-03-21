//
//  MatixView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixView: View {
    @Binding var matrix: Matrix
    var spacing: CGFloat = 2
    var showName: Bool = true
    var editable: Bool = true

    var body: some View {
        GeometryReader { geometry in
            let columns = matrix.values.first?.count ?? 0
            let cellSize = (geometry.size.width - CGFloat(2 * columns)) / CGFloat(columns)
            
                VStack(spacing: spacing) {
                    ForEach(matrix.values.indices, id: \.self) { row in
                        HStack(spacing: spacing) {
                            ForEach(matrix.values[row].indices, id: \.self) { col in
                                RoundedRectangle(cornerRadius: spacing)
                                    .fill(matrix.values[row][col] ? Color.accentColor : Color.secondary)
                                    .frame(width: cellSize, height: cellSize)
                            }
                        }
                    }
                if showName {
                    if editable {
                        TextField("Enter matrix name", text: $matrix.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                    } else {
                        Text(matrix.name)
                            .padding(.top, 15)
                    }
                }
            }
        }
    }
}

#Preview {
    MatrixView(matrix: .constant(MatrixStorage.shared.matrixes[0]))
}
