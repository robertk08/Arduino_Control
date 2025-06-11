//
//  MotorControlView.swift
//  Arduino Control
//
//  Created by Robert Krause on 11.04.25.
//

import SwiftUI

struct MotorControlView: View {
    @State var show2DView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if show2DView {
                    InverseKinematicsView()
                } else {
                    ServoControlView()
                }
            }
            .navigationTitle(Text(show2DView ? "" : "Motor Control 2D"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        show2DView.toggle()
                    } label: {
                        Label(String("Switch to " + (show2DView ? "slider" : "2D") + " View"), systemImage: show2DView ? "slider.horizontal.3" : "view.2d")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
            }
        }
    }
}

#Preview {
    MotorControlView()
}
