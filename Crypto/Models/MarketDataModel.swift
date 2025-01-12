//
//  MarketDataModel.swift
//  Crypto
//
//  Created by Giovane Barreira on 02/09/22.
//

import Foundation

struct GlobalData: Codable {
	let data: MarketDataModel?
}

struct MarketDataModel: Codable {
	let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
	let marketCapChangePercentage24HUsd: Double
	
	enum CodingKeys: String, CodingKey {
		case totalMarketCap = "total_market_cap"
		case totalVolume = "total_volume"
		case marketCapPercentage = "market_cap_percentage"
		case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
	}
	
	var marketCap: String {
		if let item = totalMarketCap.first(where: { $0.key == "brl" }) {
			return "R$" + item.value.formattedWithAbbreviations()
		}
		
		return ""
	}
	
	var volume: String {
		if let item = totalVolume.first(where: { $0.key == "brl" }) {
			return "R$" + item.value.formattedWithAbbreviations()
		}
		return ""
	}
	
	var btcDominance: String {
		if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
			return item.value.asPercentString()
		}
		return ""
	}
}
