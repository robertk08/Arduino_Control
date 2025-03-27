//
//  AnimationDetailView.swift
//  Arduino Control
//
//  Created by Robert Krause on 22.03.25.
//

import SwiftUI

struct AnimationDetailView: View {
    @Binding var animation: Animation
    
    var body: some View {
        GroupBox {
            TextField("Animation Name", text: $animation.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Divider()
                .padding(.vertical, 5)
            Text("Time between scenes: \(animation.delay, specifier: "%.2f")s")
            Slider(value: $animation.delay, in: 0.2...2, step: 0.01)
            Divider()
                .padding(.vertical, 5)
            Toggle("Repeat Animation", isOn: $animation.repeating)
                .tint(Color.accentColor)
        }
        .padding()
    }
}

#Preview {
    AnimationDetailView(animation: .constant(Animation()))
}
