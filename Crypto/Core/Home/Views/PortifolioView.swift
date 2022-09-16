//
//  PortifolioView.swift
//  Crypto
//
//  Created by Giovane Barreira on 05/09/22.
//

import SwiftUI

struct PortifolioView: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject private var vm: HomeViewModel
	@State private var selectedCoin: CoinModel? = nil
	@State private var quantityText: String = ""
	@State private var showCheckmark: Bool = false
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack(alignment: .leading, spacing: 0) {
					SearchBarView(searchText: $vm.searchText)
					coinLogoList
					
					if selectedCoin != nil {
						portfolioInputSection
					}
				}
			}
			.background(
				Color.theme.background
					.ignoresSafeArea()
			)
			.navigationTitle("Edit Portifolio")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: dismiss.callAsFunction) {
						XMarkButton()
					}
				}
				
				ToolbarItem(placement: .navigationBarTrailing) {
					trailingNavBarButtons
				}
			}
			.onChange(of: vm.searchText) { value in
				if value == "" {
					removeSelectedCoin()
				}
			}
		}
	}
}

struct PortifolioView_Previews: PreviewProvider {
	static var previews: some View {
		PortifolioView()
			.environmentObject(dev.homeVM)
	}
}

extension PortifolioView {
	private var coinLogoList: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			LazyHStack(spacing: 10) {
				ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
					CoinLogoView(coin: coin)
						.frame(width: 75)
						.padding(4)
						.onTapGesture {
							withAnimation(.easeIn) {
								updateSelectedCoins(coin: coin)
							}
						}
						.background(
							RoundedRectangle(cornerRadius: 10)
								.stroke(selectedCoin?.id == coin.id ?
												Color.theme.green : Color.clear
												, lineWidth: 1)
						)
				}
			}
			.frame(height: 120)
			.padding(.leading)
		}
	}
	
	private func updateSelectedCoins(coin: CoinModel) {
		selectedCoin = coin
		
		if let portfolioCoins = vm.portfolioCoins.first(where: { $0.id == coin.id }),
			 let amount = portfolioCoins.currentHoldings {
				quantityText = "\(amount)"
		} else {
			quantityText = ""
		}
	}
	
	private func getCurrenValue() -> Double {
		if let quantity = Double(quantityText) {
			return quantity * (selectedCoin?.currentPrice ?? 0)
		}
		return 0
	}
	
	private var portfolioInputSection: some View {
		VStack(spacing: 20) {
			HStack {
				Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "") ")
				Spacer()
				Text(selectedCoin?.currentPrice.asCurrencyWithSixDecimals() ?? "")
			}
			Divider()
			HStack {
				Text("Amount holding:")
				Spacer()
				TextField("Ex: 1.4", text: $quantityText)
					.multilineTextAlignment(.trailing)
					.keyboardType(.decimalPad)
			}
			Divider()
			HStack {
				Text("Current value:")
				Spacer()
				Text(getCurrenValue().asCurrencyWithTwoDecimals())
			}
		}
		.animation(.none)
		.padding()
		.font(.headline)
	}
	
	private var trailingNavBarButtons: some View {
		HStack(spacing: 10) {
			Image(systemName: "checkmark")
				.opacity(showCheckmark ? 1.0 : 0.0)
			Button  {
				saveButtonPressed()
			} label: {
				Text("Save".uppercased())
			}
			.opacity(
				selectedCoin != nil &&
				selectedCoin?.currentHoldings != Double(quantityText)
				? 1.0 : 0.0
			)
		}
		.font(.headline)
	}
	
	private func saveButtonPressed() {
		guard
			let coin = selectedCoin,
			let amount = Double(quantityText)
		else { return }
		
		// save to portfolio
		vm.updatePortfolio(coin: coin, amount: amount)
		
		// show checkmark
		withAnimation(.easeIn) {
			showCheckmark = true
			removeSelectedCoin()
		}
		
		// hide keyboard
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			withAnimation(.easeOut) {
				showCheckmark = false
			}
		}
	}
	
	private func removeSelectedCoin() {
		selectedCoin = nil
		vm.searchText = ""
		quantityText = ""
	}
}
