//
//  MatixView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixView: View {
    @ObservedObject var storage = MatrixStorage.shared
    @State var index: Int
    @State var showName: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            if MatrixStorage.shared.matrixes.indices.contains(index) {
                VStack {
                    let cellSize = (geometry.size.width - CGFloat(storage.matrixes[index].values[0].count) * 2) /
                    CGFloat(storage.matrixes[index].values[0].count) + 2 /
                    CGFloat(storage.matrixes[index].values[0].count)
                    
                    VStack(spacing: 2) {
                        ForEach(0..<storage.matrixes[index].values.count, id: \.self) { row in
                            HStack(spacing: 2) {
                                ForEach(0..<storage.matrixes[index].values[0].count, id: \.self) { col in
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(storage.matrixes[index].values[row][col] ? Color.accentColor : Color.secondary)
                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                    if showName {
                        TextField("Enter matrix name", text: $storage.matrixes[index].name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundStyle(Color.accentColor)
                            .frame(width: 150, alignment: .center)
                            .multilineTextAlignment(.center)
                    }
                }
            } else {
                Text("No matrix available")
            }
        }
    }
}

#Preview {
    MatrixView(index: 0)
        .frame(width: 150)
}
