//
//  UIApplication.swift
//  Crypto
//
//  Created by Giovane Barreira on 02/09/22.
//

import SwiftUI

extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
