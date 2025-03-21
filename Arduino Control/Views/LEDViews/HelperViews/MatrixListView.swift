//
//  MatrixListView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixListView: View {
    @ObservedObject var storage = MatrixStorage.shared

    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach($storage.matrixes) { $matrix in
                    HStack {
                        Text(matrix.name)
                            .frame(width: geometry.size.width / 4)
                        MatrixView(matrix: $matrix, spacing: 0, showName: false)
                            .frame(height: 75)
                    }
                }
                .onDelete { indices in
                    Haptic.feedback(.success)
                    storage.matrixes.remove(atOffsets: indices)
                }
                .onMove { indices, newOffset in
                    Haptic.feedback(.medium)
                    storage.matrixes.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .environment(\.editMode, .constant(.active))
        }
    }
}

#Preview {
    MatrixListView()
}
