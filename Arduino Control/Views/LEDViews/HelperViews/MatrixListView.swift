//
//  MatrixListView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixListView: View {
    @ObservedObject var storage1 = MatrixStorage.shared
    @ObservedObject var storage2 = AnimationStorage.shared
    @State var showAnimation = false
    @State var animationIndex = 0
    
    var matrixBinding: Binding<[Matrix]> { showAnimation ? $storage2.animations[animationIndex].matrixes : $storage1.matrixes }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                List {
                    ForEach(matrixBinding) { $matrix in
                        HStack {
                            Text(matrix.name)
                                .frame(width: geometry.size.width / 4)
                            MatrixView(matrix: $matrix, spacing: 0, showName: false)
                                .frame(height: 75)
                        }
                    }
                    .onDelete { indices in
                        Haptic.feedback(.success)
                        matrixBinding.wrappedValue.remove(atOffsets: indices)
                    }
                    .onMove { indices, newOffset in
                        Haptic.feedback(.medium)
                        matrixBinding.wrappedValue.move(fromOffsets: indices, toOffset: newOffset)
                    }
                }
                .navigationTitle("Edit Matrixes")
                .environment(\.editMode, .constant(.active))
            }
        }
    }
}

#Preview {
    MatrixListView(showAnimation: true)
}
