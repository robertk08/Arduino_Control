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
    @State private var searchText = ""

    var filteredAnimations: [Animation] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if query.isEmpty {
            return storage.animations
        } else {
            return storage.animations.filter { $0.name.lowercased().contains(query) }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredAnimations.indices, id: \.self) { index in
                    NavigationLink {
                        SingleAnimationView(index: index)
                    } label: {
                        Text(filteredAnimations[index].name)
                    }
                }
                .onDelete { indices in
                    Haptic.feedback(.success)
                    storage.animations.remove(atOffsets: indices)
                }
                .onMove { indices, newOffset in
                    Haptic.feedback(.medium)
                    storage.animations.move(fromOffsets: indices, toOffset: newOffset)
                }
                if storage.animations.isEmpty {
                    Text("No animations.  \nAdd animation by tapping the + button in the top right corner.")
                        .font(.title2)
                }
            }
            .navigationTitle("Animations")
            .searchable(text: $searchText, prompt: "Search animations...")
            .sheet(isPresented: $isAnimationSettingsViewPresent) {
                AnimationSettingsView(isNewAnimation: true, name: "", delay: 0.5, repeating: true, matrixes: [])
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .buttonStyle(.bordered)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Haptic.feedback(.selection)
                        isAnimationSettingsViewPresent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

#Preview {
    AnimationListView()
}
