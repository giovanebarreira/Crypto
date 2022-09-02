//
//  HomeView.swift
//  Crypto
//
//  Created by Giovane Barreira on 30/08/22.
//

import SwiftUI

struct HomeView: View {
	@EnvironmentObject private var vm: HomeViewModel
	@State private var showPortifolio: Bool = false
	
	var body: some View {
		ZStack {
			// background layer
			Color.theme.background
				.ignoresSafeArea()
			
			// content layer
			VStack {
				homeHeader
			
				columnTitles
			
				if !showPortifolio {
					allCoinsList
					.transition(.move(edge: .leading))
				}
				if showPortifolio {
					portifolioCoinsList
						.transition(.move(edge: .trailing))
				}
				
				Spacer(minLength: 0)
			}
		}
	}
	
	private var homeHeader: some View {
		HStack {
			CircleButtonView(iconName: showPortifolio ? "plus" : "info")
				.animation(.none, value: showPortifolio)
				.background(
					CircleButtonAnimationView(animate: $showPortifolio)
				)
			Spacer()
			Text(showPortifolio ? "Portifolio" : "Live Prices")
				.font(.headline)
				.fontWeight(.heavy)
				.foregroundColor(Color.theme.accent)
				.animation(.none, value: showPortifolio)
			Spacer()
			CircleButtonView(iconName: "chevron.right")
				.rotationEffect(Angle(degrees: showPortifolio ? 180 : 0))
				.onTapGesture {
					withAnimation(.spring()) {
						showPortifolio.toggle()
					}
				}
		}
		.padding(.horizontal)
	}
	
	private var allCoinsList: some View {
		List {
			ForEach(vm.allCoins) { coin in
				CoinRowView(coin: coin, showHoldingsColumn: false)
					.listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
			}
		}
		.listStyle(.plain)
	}
	
	private var portifolioCoinsList: some View {
		List {
			ForEach(vm.portifolioCoins) { coin in
				CoinRowView(coin: coin, showHoldingsColumn: true)
					.listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
			}
		}
		.listStyle(.plain)
	}
	
	private var columnTitles: some View {
		HStack {
			Text("Coin")
			Spacer()
			if showPortifolio {
				Text("Holdings")
			}
			Text("Price")
				.frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
		}
		.font(.caption)
		.foregroundColor(Color.theme.secondaryText)
		.padding(.horizontal)
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			HomeView()
				.navigationBarHidden(true)
		}
		.environmentObject(dev.homeVM)
	}
}


// NExt video is 7
