//
//  SingleAnimationView.swift
//  Arduino Control
//
//  Created by Robert Krause on 21.03.25.
//

import SwiftUI

struct SingleAnimationView: View {
    @ObservedObject var storage = AnimationStorage.shared
    @State var index: Int
    @State var isPlaying = false
    @State var showSettingsView = false
    @State var currentMatrixIndex = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    AnimationDetailView(name: $storage.animations[index].name, delay: $storage.animations[index].delay, repeating: $storage.animations[index].repeating)
                    MatrixView(matrix: $storage.animations[index].matrixes[0], spacing: 5, editable: false)
                        .padding(.trailing, 30)
                        .padding(10)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach($storage.animations[index].matrixes.indices, id: \.self) { matrixIndex in
                                GroupBox {
                                    MatrixView(matrix: $storage.animations[index].matrixes[matrixIndex])
                                        .frame(width: 150, height: 135)
                                        .overlay {
                                            if matrixIndex == currentMatrixIndex {
                                                RoundedRectangle(cornerRadius: 7)
                                                    .stroke(Color.accentColor, lineWidth: 4)
                                                    .foregroundStyle(Color.accentColor)
                                                    .frame(width: 180, height: 165)
                                            }
                                        }
                                }
                                .contextMenu {
                                    Button("Delete") {
                                        Haptic.feedback(.success)
                                        if !(storage.animations[index].matrixes.count == 1) {
                                            storage.animations[index].matrixes.remove(at: matrixIndex)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
                .padding()
                Spacer()
                Button {
                    isPlaying.toggle()
                } label: {
                    VStack {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    }
                    .frame(width: 90, height: 90)
                }
                .buttonStyle(.borderedProminent)

            }
            .navigationTitle(storage.animations[index].name)
            .toolbar {
                Button {
                    showSettingsView = true
                } label: {
                    Image(systemName: "gearshape.fill")
                }
                .buttonStyle(.bordered)
            }
            .sheet(isPresented: $showSettingsView) {
                AnimationSettingsView(isNewAnimation: false, name: storage.animations[index].name, delay: storage.animations[index].delay, repeating: storage.animations[index].repeating, matrixes: storage.animations[index].matrixes)
            }
    }
}

#Preview {
    SingleAnimationView(index: 0)
}
