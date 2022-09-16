//
//  String.swift
//  Crypto
//
//  Created by Giovane Barreira on 15/09/22.
//

import Foundation

extension String {
	var removeHTMLOccurances: String {
		return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
	}
}
