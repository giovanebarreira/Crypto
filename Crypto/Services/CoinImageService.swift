//
//  CoinImageService.swift
//  Crypto
//
//  Created by Giovane Barreira on 01/09/22.
//

import Combine
import SwiftUI

class CoinImageService {
	@Published var image: UIImage? = nil
	
	private var imageSubscription: AnyCancellable?
	private let coin: Coin
	private let fileManager = LocalFileManager.instance
	private let folderName = "coin_images"
	private let imageName: String

	init(coin: Coin) {
		self.coin = coin
		self.imageName = coin.id
		getCoinImage()
	}
	
	private func getCoinImage() {
		if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
			image = savedImage
		} else {
			downloadCoinImage()
		}
	}
	
	private func downloadCoinImage() {
		guard let url = URL(string: coin.image) else { return }
		
		imageSubscription = NetworkingManager.download(url: url)
			.tryMap({ (data) -> UIImage? in
				return UIImage(data: data)
			})
			.sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedImage in
				guard
					let self = self,
					let downloadImage = returnedImage
				else { return }
				
				self.image = downloadImage
				self.imageSubscription?.cancel()
				self.fileManager.saveImage(image: downloadImage, imageName: self.imageName, folderName: self.folderName)
			}
	}
}