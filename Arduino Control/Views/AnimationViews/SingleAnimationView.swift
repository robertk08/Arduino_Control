//
//  SingleAnimationView.swift
//  Arduino Control
//
//  Created by Robert Krause on 21.03.25.
//

import SwiftUI

struct SingleAnimationView: View {
    @StateObject private var viewModel = SingleAnimationViewModel()
    @ObservedObject var storage = AnimationStorage.shared
    @State var index: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                NavigationView {
                    ScrollView {
                        VStack {
                            AnimationDetailView(animation: $storage.animations[index])
                            EditMatrixView(selectedMatrix: $viewModel.selectedMatrix, showName: true)
                            MatrixOverviewView(selectedMatrix: $viewModel.selectedMatrix, showAnimation: true, animationIndex: index)
                            Spacer()
                                .frame(height: 130)
                        }
                    }
                    .onChange(of: viewModel.selectedMatrix) { oldValue, newValue in
                        if let selectedMatrixIndex = newValue.index {
                            storage.animations[index].matrixes[selectedMatrixIndex] = newValue
                        }
                    }
                    .navigationTitle(storage.animations[index].name)
                    .toolbar {
                        Button {
                            viewModel.showSettingsView = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                        .buttonStyle(.bordered)
                    }
                    .sheet(isPresented: $viewModel.showSettingsView) {
                        AnimationSettingsView(isNewAnimation: false, index: index, animation: storage.animations[index])
                    }
                }
                Button {
                    viewModel.runAnimation(storage.animations[index])
                } label: {
                    VStack {
                        Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                    }
                    .frame(width: 80, height: 80)
                }
                .buttonStyle(.borderedProminent)
                .position(x: geometry.size.width / 2, y: geometry.size.height - 80)
            }
        }
    }
}

#Preview {
    SingleAnimationView(index: 0)
}
