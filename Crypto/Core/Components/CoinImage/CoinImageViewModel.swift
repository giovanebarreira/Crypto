//
//  CoinImageViewModel.swift
//  Crypto
//
//  Created by Giovane Barreira on 01/09/22.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
	@Published var image: UIImage? = nil
	@Published var isLoading: Bool = false
	
	private let coin: Coin
	private let dataService: CoinImageService
	private var cancellables = Set<AnyCancellable>()
	
	init(coin: Coin) {
		self.coin = coin
		self.dataService = CoinImageService(coin: coin)
		addSubscribers()
		self.isLoading = true
	}
	
	private func addSubscribers() {
		dataService.$image
			.sink { [weak self] _ in
				self?.isLoading = false
			} receiveValue: { [weak self] returnedImage in
				self?.image = returnedImage
			}
			.store(in: &cancellables)
	}
}
