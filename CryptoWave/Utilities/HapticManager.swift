//
//  HapticManager.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 22/12/2023.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
