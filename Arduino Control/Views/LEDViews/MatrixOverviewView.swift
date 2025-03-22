//
//  MatrixOverviewView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixOverviewView: View {
    @StateObject private var viewModel = MatrixOverviewViewModel()
    @ObservedObject var storage1 = MatrixStorage.shared
    @ObservedObject var storage2 = AnimationStorage.shared
    @Binding var selectedMatrix: Matrix
    var selection = true
    var showAnimation = false
    var animationIndex = 0
    var matrixBinding: Binding<[Matrix]> { showAnimation ? $storage2.animations[animationIndex].matrixes : $storage1.matrixes }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(matrixBinding.indices, id: \.self) { index in
                    Button {
                        if selection {
                            selectedMatrix = matrixBinding[index].wrappedValue
                            selectedMatrix.index = index
                            Haptic.feedback(.selection)
                        }
                    } label: {
                        MatrixView(matrix: matrixBinding[index])
                            .padding(.top, 10)
                            .padding(.trailing, 5)
                            .frame(width: 155, height: 155)
                    }
                    .buttonStyle(.bordered)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(index == selectedMatrix.index ? Color.accentColor.opacity(0.75) : .secondary.opacity(0.2))
                    }
                    .padding(5)
                    .contextMenu {
                        Button("Delete") {
                            Haptic.feedback(.success)
                            matrixBinding.wrappedValue.remove(at: index)
                            if index < (selectedMatrix.index ?? 0) {
                                selectedMatrix.index = max(0, (selectedMatrix.index ?? 1) - 1)
                            } else if index == selectedMatrix.index ?? 0 {
                                selectedMatrix.index = 0
                            }
                        }
                    }
                }
                buttonView
            }
            .sheet(isPresented: $viewModel.showListView) {
                MatrixListView(showAnimation: showAnimation, animationIndex: animationIndex)
            }
            .onChange(of: selectedMatrix) { _,_ in
                viewModel.updateSelectedMatrix(selectedMatrix)
            }
        }
    }
    
    var buttonView: some View {
        Button(action: {
            viewModel.showListView = true
        }, label: {
            VStack {
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
            }
            .frame(width: 155, height: 155)
        })
        .buttonStyle(.bordered)
        .tint(.accentColor)
    }
}

#Preview {
    MatrixOverviewView(selectedMatrix: .constant(Matrix(id: UUID(), name: "Test", index: 0, values: [])))
}
