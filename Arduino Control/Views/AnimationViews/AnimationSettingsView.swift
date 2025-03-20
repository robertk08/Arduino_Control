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
    
    var body: some View {
        NavigationView {
            VStack {
                GroupBox {
                    Text("Animation Details")
                    TextField("Animation Name", text: $name)
                    Slider(value: $delay, in: 0...5, step: 0.1) {
                        Text("Delay: \(String(format: "%.1f", delay)) s")
                    }
                    Toggle("Repeat Animation", isOn: $repeating)
                }
                .padding()
                
                Text("Select Matrixes")
                SelectMatrixView(matrixes: $matrixes)
            }
            .navigationTitle(isNewAnimation ? "New Animation" : "Edit Animation: \(name)")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if !name.isEmpty || !matrixes.isEmpty  {
                            Haptic.feedback(.success)
                            AnimationStorage.shared.animations.append(Animation(id: UUID(), name: name, delay: delay, repeating: repeating, matrixes: matrixes))
                        } else {
                            showAlert = true
                            Haptic.feedback(.error)
                        }
                    }
                }
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Animation needs a name and at least one Matrix!")
            }
        }
    }
}

#Preview {
    AnimationSettingsView(isNewAnimation: false, name: "", delay: 0.5, repeating: false, matrixes: [])
}
