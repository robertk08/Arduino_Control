//
//  MatrixListView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixListView: View {
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach((MatrixStorage.shared.matrixes.indices), id: \.self) { index in
                    HStack{
                        Text(MatrixStorage.shared.matrixes[index].name)
                            .multilineTextAlignment(.leading)
                            .frame(width: geometry.size.width / 4)
                        VStack(spacing: 0) {
                            ForEach(0..<MatrixStorage.shared.matrixes[index].values.count, id: \.self) { row in
                                HStack(spacing: 0) {
                                    ForEach(0..<MatrixStorage.shared.matrixes[index].values[0].count, id: \.self) { col in
                                        Rectangle()
                                            .fill(MatrixStorage.shared.matrixes[index].values[row][col] ? Color.accentColor : Color.secondary)
                                            .frame(width: 12, height: 12)
                                    }
                                }
                            }
                        }
                    }
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
}

#Preview {
    MatrixListView()
}
