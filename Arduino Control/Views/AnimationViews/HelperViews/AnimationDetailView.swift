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
                .padding(.top, 10)
            Divider()
                .padding(.vertical, 10)
            Text("Time between scenes: \(delay, specifier: "%.2f")s")
            Slider(value: $delay, in: 0.1...5, step: 0.05)
            Divider()
                .padding(.vertical, 10)
            
            Toggle("Repeat Animation", isOn: $repeating)
                .tint(Color.accentColor)
        }
        .padding()
    }
}

#Preview {
    AnimationDetailView(name: .constant(""), delay: .constant(1), repeating: .constant(false))
}
