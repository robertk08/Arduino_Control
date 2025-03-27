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
    @Binding var animation: Animation
    @State var index: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                NavigationView {
                    ScrollView {
                            AnimationDetailView(animation: $animation)
                            EditMatrixView(selectedMatrix: $viewModel.selectedMatrix, showName: true)
                            MatrixOverviewView(selectedMatrix: $viewModel.selectedMatrix, showAnimation: true, animationIndex: index)
                            Spacer()
                                .frame(height: 130)
                    }
                    .navigationTitle(animation.name)
                    .onChange(of: viewModel.selectedMatrix) { _, newValue in
                        if let selectedMatrixIndex = newValue.index, selectedMatrixIndex > -1 {
                            animation.matrixes[selectedMatrixIndex] = newValue
                        }
                    }
                    .toolbar {
                        Button {
                            viewModel.showSettingsView = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                        .buttonStyle(.bordered)
                    }
                    .sheet(isPresented: $viewModel.showSettingsView) {
                        AnimationSettingsView(isNewAnimation: false, index: index, animation: animation)
                    }
                }
                Button {
                    viewModel.runAnimation(animation)
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
    SingleAnimationView(animation: .constant(Animation()), index: 0)
}
