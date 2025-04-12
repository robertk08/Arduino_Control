//
//  LEDControlView.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct LEDControlView: View {
    @AppStorage("showLEDControl") var showLEDControl = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if showLEDControl {
                    SingleLEDView()
                }
                MatrixControlView()
            }
            .navigationTitle("LED Control")
        }
    }
}


#Preview {
    LEDControlView()
}
