//
//  DetailViewModel.swift
//  Crypto
//
//  Created by Giovane Barreira on 12/09/22.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
	@Published var overviewStatistics: [StatisticModel] = []
	@Published var additionalStatistics: [StatisticModel] = []
	@Published var coinDescription: String? = nil
	@Published var websiteUrl: String? = nil
	@Published var redditUrl: String? = nil
	@Published var coin: CoinModel
	
	private let coinDetailService: CoinDetailDataService
	private var cancellables = Set<AnyCancellable>()
	
	init(coin: CoinModel) {
		self.coin = coin
		self.coinDetailService = CoinDetailDataService(coin: coin)
		self.addSubscribers()
	}
	
	private func addSubscribers() {
		coinDetailService.$coinDetails
			.combineLatest($coin)
			.map(mapDataToStatistics)
			.sink { [weak self] returnedArrays in
				self?.overviewStatistics = returnedArrays.overview
				self?.additionalStatistics = returnedArrays.additional
			}
			.store(in: &cancellables)
		
		coinDetailService.$coinDetails
			.sink { [weak self] returnCoinDetails in
				self?.coinDescription = returnCoinDetails?.readableDescription
				self?.websiteUrl = returnCoinDetails?.links?.homepage?.first
				self?.redditUrl = returnCoinDetails?.links?.subredditURL
			}
			.store(in: &cancellables)
	}
	
	private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
		let overviewArray = createOverviewArray(coinModel: coinModel)
		let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
		return (overviewArray, additionalArray)
	}
	
	private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
		let price = coinModel.currentPrice.asCurrencyWithSixDecimals()
		let pricePercentChange = coinModel.priceChangePercentage24H
		let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
		
		let marketCap = "R$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
		let maketCapPercentChange = coinModel.marketCapChangePercentage24H
		let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: maketCapPercentChange)
		
		let rank = "\(coinModel.rank)"
		let rankStat = StatisticModel(title: "Rank", value: rank)
		
		let volume = "R$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
		let volumeStat = StatisticModel(title: "Volume", value: volume)
		
		let overviewArray: [StatisticModel] = [
			priceStat, marketCapStat, rankStat, volumeStat
		]
		
		return overviewArray
	}
	
	private func createAdditionalArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
		let high = coinModel.high24H?.asCurrencyWithSixDecimals() ?? "n/a"
		let highStat = StatisticModel(title: "24h High", value: high)
		
		let low = coinModel.low24H?.asCurrencyWithSixDecimals() ?? "n/a"
		let lowStat = StatisticModel(title: "24h Low", value: low)
		
		let priceChange = coinModel.priceChangePercentage24H?.asCurrencyWithSixDecimals() ?? "n/a"
		let pricePercentChange = coinModel.priceChangePercentage24H
		let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
		
		let marketCapChange = "R$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
		let marketCapPercentChange = coinModel.marketCapChangePercentage24H
		let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
		
		let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
		let blockTimeString = blockTime == 0 ? "n/a": "\(blockTime)"
		let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
		
		let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
		let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
		
		let additionalArray: [StatisticModel] = [
			highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
		]
		
		return additionalArray
	}
}
