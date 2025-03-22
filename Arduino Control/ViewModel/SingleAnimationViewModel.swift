//
//  SingleAnimationViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 22.03.25.
//

import Foundation
import SwiftUICore

class SingleAnimationViewModel: ObservableObject {
    @ObservedObject var storage = AnimationStorage.shared
    @Published var showSettingsView = false
    @Published var selectedMatrix = AnimationStorage.shared.emthyMatrix
    @Published var isPlaying = false
    private var blinkTimer: Timer?
    private var index = 0
    
    func runAnimation(_ index: Int) {
        self.index = index
        Haptic.feedback(.success)
        if blinkTimer != nil {
            blinkTimer?.invalidate()
            blinkTimer = nil
            isPlaying = false
            selectedMatrix = AnimationStorage.shared.emthyMatrix
            selectedMatrix.index = -1
        } else {
            selectedMatrix = AnimationStorage.shared.emthyMatrix
            selectedMatrix.index = -1
            isPlaying = true
            scheduleNextAnimation(after: storage.animations[index].delay)
        }
    }
    
    private func scheduleNextAnimation(after delay: TimeInterval) {
        blinkTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            let currentIndex = self.selectedMatrix.index ?? 0
            if currentIndex < storage.animations[index].matrixes.count - 1 {
                selectedMatrix = storage.animations[index].matrixes[currentIndex + 1]
                selectedMatrix.index = currentIndex + 1
                self.scheduleNextAnimation(after: storage.animations[index].delay)
            } else if (currentIndex == storage.animations[index].matrixes.count - 1) && storage.animations[index].repeating{
                selectedMatrix = storage.animations[index].matrixes[0]
                selectedMatrix.index = 0
                self.scheduleNextAnimation(after: storage.animations[index].delay)
            } else if (currentIndex == storage.animations[index].matrixes.count - 1) && !storage.animations[index].repeating{
                runAnimation(index)
            }
        }
    }
}
