//
//  MatrixOverviewView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixOverviewView: View {
    @Binding var matrixes: [Matrix]
    @Binding var selectedMatrix: Matrix
    @State var showListView = false
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(matrixes.indices, id: \.self) { index in
                    GroupBox {
                        MatrixView(matrix: $matrixes[index])
                            .frame(width: 150, height: 110)
                    }
                    .padding(10)
                    .contextMenu {
                        Button("Delete") {
                            if matrixes.count > 1 {
                                matrixes.remove(at: index)
                            }
                        }
                        .disabled(matrixes.count == 1)
                    }
                    .onTapGesture {
                        selectedMatrix = matrixes[index]
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
                MatrixListView(matrixes: $matrixes)
            }
        }
    }
}
