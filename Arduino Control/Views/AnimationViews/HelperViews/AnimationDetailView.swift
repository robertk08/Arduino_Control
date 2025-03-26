//
//  AnimationDetailView.swift
//  Arduino Control
//
//  Created by Robert Krause on 22.03.25.
//

import SwiftUI

struct AnimationDetailView: View {
    @Binding var name: String
    @Binding var delay: Double
    @Binding var repeating: Bool
    
    var body: some View {
        GroupBox {
            TextField("Animation Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Divider()
                .padding(.vertical, 5)
            Text("Time between scenes: \(delay, specifier: "%.2f")s")
            Slider(value: $delay, in: 0.1...2, step: 0.01)
            Divider()
                .padding(.vertical, 5)
            Toggle("Repeat Animation", isOn: $repeating)
                .tint(Color.accentColor)
        }
        .padding()
    }
}

#Preview {
    AnimationDetailView(name: .constant(""), delay: .constant(1), repeating: .constant(false))
}
