//
//  AnimationListView.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import SwiftUI

struct AnimationListView: View {
    @ObservedObject var storage = AnimationStorage.shared
    @State private var isAnimationSettingsViewPresent = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(storage.animations.indices, id: \.self) { index in
                    NavigationLink {
                        SingleAnimationView(index: index)
                    } label: {
                        Text(AnimationStorage.shared.animations[index].name)
                    }

                }
                .onDelete { indices in
                    AnimationStorage.shared.animations.remove(atOffsets: indices)
                    Haptic.feedback(.success)
                }
                .onMove { indices, newOffset in
                    AnimationStorage.shared.animations.move(fromOffsets: indices, toOffset: newOffset)
                    Haptic.feedback(.medium)
                }
            }
            .navigationTitle("Animation")
            .sheet(isPresented: $isAnimationSettingsViewPresent, content: {
                AnimationSettingsView(isNewAnimation: true, name: "", delay: 0.5, repeating: false, matrixes: [])
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .buttonStyle(.bordered)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAnimationSettingsViewPresent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .onAppear {
                print(AnimationStorage.shared.animations)
            }
        }
    }
}

#Preview {
    AnimationListView()
}
