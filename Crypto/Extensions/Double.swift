//
//  Double.swift
//  Crypto
//
//  Created by Giovane Barreira on 30/08/22.
//

import Foundation

extension Double {
	/// Converts a Double into a Currency with 2 decimal places
	/// ```
	///Convert 1234.56 to $1,234.56
	/// ```
	private var currencyFormatter2: NumberFormatter {
		let formatter = NumberFormatter()
		formatter.usesGroupingSeparator = true
		formatter.numberStyle = .currency
		formatter.locale = .current // <- default value
		formatter.currencyCode = "brl" // <- change currency
		formatter.currencySymbol = "R$" // <- change currency symbol
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 2
		return formatter
	}
	
	/// Converts a Double into a Currency as a String with 2 decimal places
	/// ```
	///Convert 1234.56 to "$1,234.56"
	/// ```
	func asCurrencyWithTwoDecimals() -> String {
		let number = NSNumber(value: self)
		return currencyFormatter2.string(from: number) ?? "R$0.00"
	}
	
	/// Converts a Double into a Currency with 2-6 decimal places
	/// ```
	///Convert 1234.56 to $1,234.56
	///Convert 12.3456 to $12.3456
	///Convert 0.123456 to $0.123456
	/// ```
	private var currencyFormatter6: NumberFormatter {
		let formatter = NumberFormatter()
		formatter.usesGroupingSeparator = true
		formatter.numberStyle = .currency
		formatter.locale = .current // <- default value
		formatter.currencyCode = "brl" // <- change currency
		formatter.currencySymbol = "R$" // <- change currency symbol
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 6
		return formatter
	}
	
	/// Converts a Double into a Currency as a String with 2-6 decimal places
	/// ```
	///Convert 1234.56 to "$1,234.56"
	///Convert 12.3456 to "$12.3456"
	///Convert 0.123456 to "$0.123456"
	/// ```
	func asCurrencyWithSixDecimals() -> String {
		let number = NSNumber(value: self)
		return currencyFormatter6.string(from: number) ?? "R$0.00"
	}
	
	/// Converts a Double into a String representation
	/// ```
	///Convert 1.23456 to "1.23"
	/// ```
	func asNumberString() -> String {
		return String(format: "%.2f", self)
	}
	
	/// Converts a Double into a String representation with percentage symbol
	/// ```
	///Convert 1.23456 to "1.23%"
	/// ```
	func asPercentString() -> String {
		return asNumberString() + "%"
	}
}
