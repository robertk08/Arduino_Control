//
//  SingleAnimationViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 22.03.25.
//

import Foundation
import SwiftUI

class SingleAnimationViewModel: ObservableObject {
    @ObservedObject var storage = AnimationStorage.shared
    @Published var showSettingsView = false
    @Published var selectedMatrix = Matrix()
    @Published var isPlaying = false
    private var blinkTimer: Timer?
    private var animation = Animation()
    
    func runAnimation(_ animation: Animation) {
        self.animation = animation
        Haptic.feedback(.success)
        
        if blinkTimer != nil {
            blinkTimer?.invalidate()
            blinkTimer = nil
            isPlaying = false
            selectedMatrix = Matrix(index: -1)
        } else {
            selectedMatrix = Matrix(index: -1)
            isPlaying = true
            scheduleNextAnimation()
        }
    }
    
    private func scheduleNextAnimation() {
        blinkTimer = Timer.scheduledTimer(withTimeInterval: animation.delay, repeats: false) { [weak self] _ in
            guard let self else { return }
            let currentIndex = selectedMatrix.index ?? 0
            let length = animation.matrixes.count - 1
            if currentIndex < length {
                selectedMatrix = animation.matrixes[currentIndex + 1]
                selectedMatrix.index = currentIndex + 1
                scheduleNextAnimation()
            } else if currentIndex == length && animation.repeating{
                selectedMatrix = animation.matrixes[0]
                selectedMatrix.index = 0
                scheduleNextAnimation()
            } else if currentIndex == length && !animation.repeating{
                runAnimation(animation)
            }
        }
    }
}
