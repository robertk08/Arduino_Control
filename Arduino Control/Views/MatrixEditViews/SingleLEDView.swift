//
//  SingleLEDView.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import SwiftUI

struct SingleLEDView: View {
    @StateObject private var viewModel = SingleLEDViewModel()
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(viewModel.isOn ? .accentColor : Color.gray)
                .frame(height: 35)
                .padding(.top)
                .padding(.horizontal)
                .onTapGesture {
                    viewModel.isOn.toggle()
                    Haptic.feedback(.rigid)
                }
                .overlay {
                    Image(systemName: "memorychip")
                        .padding(.top)
                }
            
            GroupBox {
                Text("On Duration: \(viewModel.onDuration, specifier: "%.2f")s")
                Slider(value: $viewModel.onDuration, in: 0.01...5.0, step: 0.01)
                Text("Off Duration: \(viewModel.offDuration, specifier: "%.02f")s")
                Slider(value: $viewModel.offDuration, in: 0.01...5.0, step: 0.01)
            }
            .padding()
            
            Divider()
        }
        .onChange(of: viewModel.isOn) { _,_ in
            viewModel.updateLED()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.blink()
                } label: {
                    Image(systemName: viewModel.isBlinking ? "lightswitch.on" : "lightswitch.off")
                }
                .buttonStyle(.bordered)
                .tint(viewModel.isBlinking ? Color.accentColor : .primary)
            }
        }
    }
}

#Preview {
    SingleLEDView()
}
