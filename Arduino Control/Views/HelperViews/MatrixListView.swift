//
//  MatrixListView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixListView: View {
    var body: some View {
        List {
            ForEach(MatrixStorage.shared.matrixes, id: \.id) { matrix in
                Text(matrix.name)
            }
            .onDelete { indices in
                MatrixStorage.shared.matrixes.remove(atOffsets: indices)
                Haptic.feedback(.rigid)
            }
            .onMove { indices, newOffset in
                MatrixStorage.shared.matrixes.move(fromOffsets: indices, toOffset: newOffset)
                Haptic.feedback(.medium)
            }
        }
        .environment(\.editMode, .constant(.active))
    }
}

#Preview {
    MatrixListView()
}
