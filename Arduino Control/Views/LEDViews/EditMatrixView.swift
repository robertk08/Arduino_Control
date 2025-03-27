//
//  EditMatrixView.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import SwiftUI

struct EditMatrixView: View {
    @AppStorage("isOn") var isOn = true
    @Binding var selectedMatrix: Matrix
    var showName = false
    
    var body: some View {
        GroupBox {
            selection
            MatrixView(matrix: $selectedMatrix, spacing: 5, showName: showName, matrixEditable: true, nameEditable: false)
                .padding(.trailing, 30)
        }
        .frame(height: showName ? 370 : 345)
        .padding(10)
    }
    
    var selection: some View {
        GroupBox {
            HStack {
                Text("Led mode:")
                    .font(.title3)
                    .padding(.horizontal)
                Picker("Mode", selection: $isOn) {
                    Text("⬜️").tag(false)
                    Text("🟪").tag(true)
                }
                .pickerStyle(.segmented)
            }
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    EditMatrixView(selectedMatrix: .constant(Matrix()))
}
