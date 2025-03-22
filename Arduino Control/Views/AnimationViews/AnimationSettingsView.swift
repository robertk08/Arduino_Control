//
//  AnimationSettingsView.swift
//  Arduino Control
//
//  Created by Robert Krause on 20.03.25.
//

import SwiftUI

struct AnimationSettingsView: View {
    @State var isNewAnimation: Bool
    @State var name: String
    @State var delay: Double
    @State var repeating: Bool
    @State var matrixes: [Matrix]
    @State var showAlert = false
    @State var index: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Animation Details")
                        .font(.headline)
                        .padding(.top)
                    AnimationDetailView(name: $name, delay: $delay, repeating: $repeating)
                    Divider()
                    Text("Select Matrixes")
                        .font(.headline)
                        .padding()
                    SelectMatrixView(matrixes: $matrixes)
                }
            }
            .navigationTitle(isNewAnimation ? "New Animation" : "Edit Animation: \(name)")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if !name.isEmpty || !matrixes.isEmpty  {
                            Haptic.feedback(.success)
                            if isNewAnimation {
                                AnimationStorage.shared.animations.append(Animation(id: UUID(), name: name, delay: delay, repeating: repeating, matrixes: matrixes))
                            } else {
                                AnimationStorage.shared.animations[index] =  Animation(id: UUID(), name: name, delay: delay, repeating: repeating, matrixes: matrixes)
                            }
                            dismiss.callAsFunction()
                        } else {
                            showAlert = true
                            Haptic.feedback(.error)
                        }
                    }
                    .buttonStyle(.bordered)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        Haptic.feedback(.rigid)
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "xmark.square.fill")
                    }
                    .buttonStyle(.bordered)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        Haptic.feedback(.success)
                        matrixes.removeAll()
                    } label: {
                        Image(systemName: "arrow.uturn.forward.square.fill")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Animation needs a name and at least one Matrix!")
            }
            .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    AnimationSettingsView(isNewAnimation: false, name: "", delay: 0.5, repeating: false, matrixes: [])
}


