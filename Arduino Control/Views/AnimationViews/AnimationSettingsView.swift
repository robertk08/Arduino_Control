//
//  AnimationSettingsView.swift
//  Arduino Control
//
//  Created by Robert Krause on 20.03.25.
//

import SwiftUI

struct AnimationSettingsView: View {
    @StateObject private var viewModel = AnimationSettingsViewModel()
    @Environment(\.dismiss) var dismiss
    @State var isNewAnimation: Bool
    @State var index: Int = 0
    @State var animation: Animation
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Animation Details")
                    .font(.headline)
                    .padding(.top)
                    .underline()
                AnimationDetailView(animation: $animation)
                Text("Select Matrixes")
                    .font(.headline)
                    .padding(.bottom)
                    .underline()
                SelectMatrixView(matrixes: $animation.matrixes)
            }
            .navigationTitle(isNewAnimation ? "New Animation" : "Edit: \(animation.name)")
            .toolbar { toolbarContent }
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: { Text("Animation needs a name and at least one Matrix.") }
        }
        .interactiveDismissDisabled(true)
    }
    
    var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if viewModel.save(animation: animation, index: index, isNewAnimation: isNewAnimation) { dismiss() }
                } label: {
                    Image(systemName: isNewAnimation ? "plus" : "pencil")
                }
                .buttonStyle(.bordered)
            }
            
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    Haptic.feedback(.rigid)
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.bordered)
                
                Button {
                    Haptic.feedback(.success)
                    animation.matrixes.removeAll()
                } label: {
                    Image(systemName: "gobackward")
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    AnimationSettingsView(isNewAnimation: false, index: 0, animation: Animation())
}
