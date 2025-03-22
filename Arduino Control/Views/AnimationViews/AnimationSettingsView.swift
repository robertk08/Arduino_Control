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
                Text("Animation Details")
                    .font(.headline)
                    .padding(.top)
                    .underline()
                AnimationDetailView(name: $name, delay: $delay, repeating: $repeating)
                Text("Select Matrixes")
                    .font(.headline)
                    .padding(.bottom)
                    .underline()
                SelectMatrixView(matrixes: $matrixes)
            }
            .navigationTitle(isNewAnimation ? "New Animation" : "Edit: \(name)")
            .toolbar { toolbarContent }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: { Text("Animation needs a name and at least one Matrix.") }
        }
        .interactiveDismissDisabled(true)
    }
    
    var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if !(name.isEmpty || matrixes.isEmpty)  {
                        Haptic.feedback(.success)
                        if isNewAnimation {
                            AnimationStorage.shared.animations.append(Animation(id: UUID(), name: name, delay: delay, repeating: repeating, matrixes: matrixes))
                        } else {
                            AnimationStorage.shared.animations[index] = Animation(id: UUID(), name: name, delay: delay, repeating: repeating, matrixes: matrixes)
                        }
                        dismiss.callAsFunction()
                    } else {
                        showAlert = true
                        Haptic.feedback(.error)
                    }
                } label: {
                    Image(systemName: isNewAnimation ? "plus" : "pencil")
                }
                .buttonStyle(.bordered)
            }
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    Haptic.feedback(.rigid)
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.bordered)
                
                Button {
                    Haptic.feedback(.success)
                    matrixes.removeAll()
                } label: {
                    Image(systemName: "gobackward")
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    AnimationSettingsView(isNewAnimation: false, name: "", delay: 0.5, repeating: false, matrixes: [])
}
