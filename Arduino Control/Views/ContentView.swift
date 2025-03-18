//
//  ContentView.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ArduinoViewModel()
    @StateObject private var matrixStore = MatrixStore()
    @State private var selectedMatrix = MatrixStore.init().matrices.first!
    
    var body: some View {
        NavigationView {
                ScrollView {
                    VStack(spacing: 0) {
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(viewModel.isOn ? .accentColor : Color.gray)
                            .frame(height: 20)
                            .padding()
                            .onTapGesture {
                                viewModel.isOn.toggle()
                                Haptic.feedback(.selection)
                            }
                        
                        HStack {
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
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
                        
                        
                        Divider()
                            .padding(.vertical)
                        
                        GroupBox {
                            LedMatrix(matrix: $selectedMatrix)
                                .frame(height: 285)
                        }
                        .padding(10)
                        Divider()
                            .padding(.vertical)
                        
                        MatrixOverviewView(matrixes: $matrixStore.matrices, selectedMatrix: $selectedMatrix)
                        
                        HStack {
                            Button("Save Matrix") {
                                matrixStore.matrices.append(
                                    Matrix(id: UUID(), name: "Scene \(matrixStore.matrices.count + 1)", values: selectedMatrix.values)
                                )
                            }
                            .buttonStyle(BorderedButtonStyle())
                            Button("Save Edit (Override)") {
                                matrixStore.matrices[0] = selectedMatrix
                            }
                            .buttonStyle(BorderedButtonStyle())
                        }
                    }
                    .onChange(of: selectedMatrix) { _, newValue in
                        //update 
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
