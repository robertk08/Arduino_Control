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
        GeometryReader { geometry in
            ZStack {
                NavigationView {
                    ScrollView {
                        VStack {
                            AnimationDetailView(name: $storage.animations[index].name, delay: $storage.animations[index].delay, repeating: $storage.animations[index].repeating)
                            MatrixView(matrix: $storage.animations[index].matrixes[0], spacing: 5, editable: false)
                                .padding(.trailing, 30)
                                .padding(10)
                                .frame(height: 290)
                            MatrixOverviewView(selectedMatrix: $storage.animations[index].matrixes[currentMatrixIndex])
                            Spacer()
                                .frame(height: 100)
                        }
                    }
                    .padding()
                    .navigationTitle(storage.animations[index].name)
                    .toolbar {
                        Button {
                            showSettingsView = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                        .buttonStyle(.bordered)
                        .position(x: 200, y: 0)
                    }
                    .sheet(isPresented: $showSettingsView) {
                        AnimationSettingsView(isNewAnimation: false, name: storage.animations[index].name, delay: storage.animations[index].delay, repeating: storage.animations[index].repeating, matrixes: storage.animations[index].matrixes)
                    }
                }
                
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
                .position(x: geometry.size.width / 2, y: geometry.size.height - 50)
            }
        }
    }
    }

#Preview {
    SingleAnimationView(index: 0)
}

class MatrixOverviewViewModel2: ObservableObject {
    @Published var showListView = false
    @Published var sendCommandTimer: Timer? = nil
    
    func updateSelectedMatrix(_ selectedMatrix: Matrix) {
        if sendCommandTimer == nil {
            sendCommandTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                let command = ControlCommand(device: "Matrix", action: 1, values: selectedMatrix.values.toIntArray())
                ConnectionService.sendRequest(command: command)
                self.sendCommandTimer = nil
            }
        }
    }
}
