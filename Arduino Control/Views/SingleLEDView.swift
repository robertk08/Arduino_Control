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
                .frame(height: 20)
                .padding()
                .onTapGesture {
                    viewModel.isOn.toggle()
                    Haptic.feedback(.selection)
                }
            
            GroupBox {
                VStack {
                    Text("On Duration: \(viewModel.onDuration, specifier: "%.1f")s")
                    Slider(value: $viewModel.onDuration, in: 0.1...5.0, step: 0.1)
                }
                
                VStack {
                    Text("Off Duration: \(viewModel.offDuration, specifier: "%.1f")s")
                    Slider(value: $viewModel.offDuration, in: 0.1...5.0, step: 0.1)
                }
            }
            .padding()
        }
        .onChange(of: viewModel.isOn) { _,newValue in
            let command = ControlCommand(device: "LED", action: newValue ? "on" : "off")
            ConnectionService.sendRequest(command: command, arduinoIP: viewModel.arduinoIP)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.blink()
                } label: {
                    Text("Blink")
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
