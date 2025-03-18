//
//  MatrixListView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixListView: View {
    @Binding var matrixes: [Matrix]
    
    var body: some View {
        List {
            ForEach(matrixes, id: \.id) { matrix in
                Text(matrix.name)
            }
            .onDelete(perform: delete)
            .onMove(perform: move)
        }
        .environment(\.editMode, .constant(.active)) // Always in edit mode
    }

    private func delete(at offsets: IndexSet) {
        matrixes.remove(atOffsets: offsets)
    }

    private func move(from source: IndexSet, to destination: Int) {
        matrixes.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    //MatrixListView()
}
