//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Giovane Barreira on 31/08/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
	@Published var allCoins: [Coin] = []
	@Published var portifolioCoins: [Coin] = []
	
	private let dataService = CoinDataService()
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		addSubscribers()
	}
	
	func addSubscribers() {
		dataService.$allCoins
			.sink { [weak self] returnedCoins in
				self?.allCoins = returnedCoins
			}
			.store(in: &cancellables)
	}
}
