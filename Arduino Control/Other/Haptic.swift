//
//  Haptic.swift
//  ToDoList
//
//  Created by Robert Krause on 09.05.24.
//

import SwiftUI

enum FeedbackType {
    case selection, success, error, warning, light, soft, medium, heavy, rigid
}

struct Haptic {
    static func feedback(_ type: FeedbackType) {
        switch type {
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .light, .soft, .medium, .heavy, .rigid:
            let style: UIImpactFeedbackGenerator.FeedbackStyle
            switch type {
            case .light: style = .light
            case .soft: style = .soft
            case .medium: style = .medium
            case .heavy: style = .heavy
            case .rigid: style = .rigid
            default: return
            }
            UIImpactFeedbackGenerator(style: style).impactOccurred()
        }
    }
}
