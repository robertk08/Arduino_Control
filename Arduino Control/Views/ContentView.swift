//
//  ContentView.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ArduinoViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(viewModel.isOn ? .red : Color.gray)
                        .frame(width: geometry.size.width - 20, height: 20)
                        .padding(.vertical)
                        .onTapGesture {
                            viewModel.isOn.toggle()
                            Haptic.feedback(.selection)
                        }
                    
                    HStack {
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Text("On Duration: \(viewModel.onDuration, specifier: "%.1f")s")
                        Slider(value: $viewModel.onDuration, in: 0.1...5.0, step: 0.1)
                    }
                    .padding()
                    
                    VStack {
                        Text("Off Duration: \(viewModel.offDuration, specifier: "%.1f")s")
                        Slider(value: $viewModel.offDuration, in: 0.1...5.0, step: 0.1)
                    }
                    .padding()
                    
                    LedMatrix()
                }
                .onChange(of: viewModel.isOn) { _,newValue in
                    let command = ControlCommand(device: "LED", action: newValue ? "on" : "off")
                    ConnectionService.sendRequest(command: command, arduinoIP: viewModel.arduinoIP)
                }
                .sheet(isPresented: $viewModel.showSettingsView) {
                    SettingsView()
                }
                .navigationTitle("Arduino Control")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showSettingsView.toggle()
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        .buttonStyle(.bordered)
                        .tint(Color.accentColor)
                    }
                    
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
    }
}


#Preview {
    ContentView()
}
