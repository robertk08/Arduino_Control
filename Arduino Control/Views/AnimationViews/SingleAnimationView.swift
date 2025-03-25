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
                            AnimationDetailView(name: $storage.animations[index].name, delay: $storage.animations[index].delay, repeating: $storage.animations[index].repeating)
                            MatrixView(matrix: $viewModel.selectedMatrix, spacing: 3, editable: false)
                                .padding(.trailing, 30)
                                .padding(10)
                                .frame(height: geometry.size.width / 12 * 8 + 20)
                            MatrixOverviewView(selectedMatrix: $viewModel.selectedMatrix, selection: false, showAnimation: true, animationIndex: index)
                            Spacer()
                                .frame(height: 130)
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
                        AnimationSettingsView(isNewAnimation: false, name: storage.animations[index].name, delay: storage.animations[index].delay, repeating: storage.animations[index].repeating, matrixes: storage.animations[index].matrixes)
                    }
                }
                Button {
                    viewModel.runAnimation(index)
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
