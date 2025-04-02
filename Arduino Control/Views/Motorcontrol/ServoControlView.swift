//
//  ServoControlView.swift
//  Arduino Control
//
//  Created by Robert Krause on 01.04.25.
//

import SwiftUI

struct ServoControlView: View {
    @State var positions = (0..<6).map { ServoPosition(id: $0) }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 270, maximum: 360))], spacing: 15) {
                    ForEach(0..<6) { index in
                        SingleServoView(position: $positions[index])
                    }
                }
            }
            .navigationTitle("Servo Control")
        }
    }
}

#Preview {
    ServoControlView()
}
