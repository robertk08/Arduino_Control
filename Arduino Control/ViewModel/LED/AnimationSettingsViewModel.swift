//
//  AnimationSettingsViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 26.03.25.
//

import Foundation

class AnimationSettingsViewModel: ObservableObject {
    @Published var showAlert = false
    
    func save(animation: Animation, index: Int, isNewAnimation: Bool) -> Bool {
        if !(animation.name.isEmpty || animation.matrixes.isEmpty)  {
            Haptic.feedback(.success)
            if isNewAnimation {
                AnimationStorage.shared.animations.append(animation)
            } else {
                AnimationStorage.shared.animations[index] = animation
            }
            return true
        } else {
            showAlert = true
            Haptic.feedback(.error)
            return false
        }
    }
}
