//
//  LEDControlView.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct LEDControlView: View {
    @StateObject private var viewModel = LEDControlViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    if viewModel.showLEDControl {
                        SingleLEDView()
                    }
                    
                    Divider()
                        .padding(.vertical)
                    
                    AllMatrixView()
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
                }
            }
        }
    }
}


#Preview {
    LEDControlView()
}

struct AllMatrixView: View {
    @StateObject private var viewModel = LEDControlViewModel()

    var body: some View {
        GroupBox {
            LedMatrix(matrix: $viewModel.selectedMatrix)
                .frame(height: 285)
        }
        .padding(10)
        Divider()
            .padding(.vertical)
        
        MatrixOverviewView(selectedMatrix: $viewModel.selectedMatrix)
        
        HStack {
            Button {
                MatrixStorage.shared.matrixes.append(
                    Matrix(id: UUID(), name: "Scene \(MatrixStorage.shared.matrixes.count + 1)", values: viewModel.selectedMatrix.values))
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button {
                MatrixStorage.shared.matrixes[0] = viewModel.selectedMatrix
            } label: {
                Image(systemName: "pencil")
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .onChange(of: viewModel.selectedMatrix) { _, newValue in
            //update
        }
    }
}
