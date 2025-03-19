//
//  MatixView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixView: View {
    @State var matrix: Matrix
    
    init(index: Int) {
        self.matrix = MatrixStorage.shared.matrixes[index]
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                let cellSize = (geometry.size.width - CGFloat(matrix.values[0].count) * 2) / CGFloat(matrix.values[0].count) + 2 / CGFloat(matrix.values[0].count)

                VStack(spacing: 2) {
                    ForEach(0..<matrix.values.count, id: \.self) { row in
                        HStack(spacing: 2) {
                            ForEach(0..<matrix.values[0].count, id: \.self) { col in
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(matrix.values[row][col] ? Color.accentColor : Color.secondary)
                                    .frame(width: cellSize, height: cellSize)
                            }
                        }
                    }
                }
                TextField("Enter matrix name", text: $matrix.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 150, alignment: .center)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    MatrixView(index: 1)
}
