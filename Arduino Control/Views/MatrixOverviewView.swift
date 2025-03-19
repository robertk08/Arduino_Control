//
//  MatrixOverviewView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixOverviewView: View {
    @Binding var selectedMatrix: Matrix
    @State var showListView = false
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(MatrixStorage.shared.matrixes.indices, id: \.self) { index in
                    GroupBox {
                        MatrixView(index: index)
                            .frame(width: 150, height: 110)
                    }
                    .padding(10)
                    .contextMenu {
                        Button("Delete") {
                            if MatrixStorage.shared.matrixes.count > 1 {
                                Haptic.feedback(.success)
                                MatrixStorage.shared.matrixes.remove(at: index)
                            }
                        }
                        .disabled(MatrixStorage.shared.matrixes.count == 1)
                    }
                    .onTapGesture {
                        selectedMatrix = MatrixStorage.shared.matrixes[index]
                    }
                }
                GroupBox {
                    Button(action: {
                        showListView = true
                    }, label: {
                        VStack {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                        }
                        .frame(width: 120, height: 90)
                    })
                    .tint(.accentColor)
                    .buttonStyle(BorderedButtonStyle())
                    .frame(width: 150, height: 110)
                }
                .padding(10)
                
            }
            .sheet(isPresented: $showListView) {
                MatrixListView()
            }
        }
    }
}

#Preview {
    MatrixOverviewView(selectedMatrix: .constant(MatrixStorage.shared.matrixes.first!))
}
