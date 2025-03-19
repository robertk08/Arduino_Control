//
//  AnimationListView.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import SwiftUI

struct AnimationListView: View {
    var body: some View {
        List {
            ForEach(MatrixStorage.shared.matrixes, id: \.id) { matrix in
                Text(matrix.name)
            }
            .onDelete { indices in
                MatrixStorage.shared.matrixes.remove(atOffsets: indices)
                Haptic.feedback(.success)
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
    AnimationListView()
}
