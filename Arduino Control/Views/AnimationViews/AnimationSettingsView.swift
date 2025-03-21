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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Animation Details")
                        .font(.headline)
                        .padding(.top)
                    GroupBox {
                        TextField("Animation Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.top, 10)
                        Divider()
                            .padding(.vertical, 10)
                        Text("Time between scenes: \(delay, specifier: "%.2f")s")
                        Slider(value: $delay, in: 0.1...5, step: 0.05)
                        Divider()
                            .padding(.vertical, 10)
                        
                        Toggle("Repeat Animation", isOn: $repeating)
                    }
                    .padding()
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
                            AnimationStorage.shared.animations.append(Animation(id: UUID(), name: name, delay: delay, repeating: repeating, matrixes: matrixes))
                            dismiss.callAsFunction()
                        } else {
                            showAlert = true
                            Haptic.feedback(.error)
                        }
                    }
                    .buttonStyle(.bordered)

                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        Haptic.feedback(.rigid)
                        dismiss.callAsFunction()
                    }
                    .buttonStyle(.bordered)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset Matrixes") {
                        matrixes.removeAll()
                        Haptic.feedback(.success)
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
