//
//  HapticManager.swift
//  Crypto
//
//  Created by Giovane Barreira on 08/09/22.
//

import Foundation
import SwiftUI

class HapticManager {
	static let generator = UINotificationFeedbackGenerator()
	
	static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
		generator.notificationOccurred(type)
	}
}
