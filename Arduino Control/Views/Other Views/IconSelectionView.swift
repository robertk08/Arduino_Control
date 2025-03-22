//
//  IconSelectionView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct IconSelectionView: View {
    let icons = ["Chip", "Chip-Wifi", "Chip-Pentagon-Sparkle", "Chip-Pentagon-Wifi", "Memory"]
    @AppStorage("selectedIconIndex") var selectedIconIndex: Int = 0
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Select App Icon")
                .font(.title2)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(icons, id: \.self) { icon in
                        if let index = icons.firstIndex(of: icon) {
                            Button(action: {
                                Haptic.feedback(.success)
                                selectedIconIndex = index
                                let iconName = "AppIcon \(index + 1)"
                                UIApplication.shared.setAlternateIconName(iconName == "AppIcon 1" ? nil : iconName) { error in
                                    if let error = error {
                                        print("Failed to change app icon: \(error.localizedDescription)")
                                    }
                                }
                                   dismiss()
                                   }) {
                                VStack {
                                    Image(icon)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.accentColor, lineWidth: selectedIconIndex == index ? 4 : 1)
                                        )
                                    Text(icon)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .presentationDetents([.fraction(0.3)])
        .presentationCornerRadius(20)
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    IconSelectionView()
}
