//
//  SettingsView.swift
//  Crypto
//
//  Created by Giovane Barreira on 15/09/22.
//

import SwiftUI

struct SettingsView: View {
	// MARK: - Properties that could be in a View Model
	let defaultUrl = URL(string: "https://www.google.com")!
	let youtubeUrl = URL(string: "https://www.youtube.com")!
	let coffeeUrl = URL(string: "https://www.buymeacoffee.com")!
	let coingeckoUrl = URL(string: "https://www.coingecko.com")!
	let personalUrl = URL(string: "https://www.linkedin.com/in/giovane-barreira-a073b4b9/")!
	
	
	var body: some View {
		NavigationView {
			ZStack {
				Color.theme.background
					.ignoresSafeArea()
				List {
					presentationSection
						.listRowBackground(Color.theme.background.opacity(0.5))
					coingeckoSection
						.listRowBackground(Color.theme.background.opacity(0.5))
					developerSection
						.listRowBackground(Color.theme.background.opacity(0.5))
					applicationSection
						.listRowBackground(Color.theme.background.opacity(0.5))
				}
				.font(.headline)
				.accentColor(.blue)
				.listStyle(.grouped)
				.navigationTitle("Settings")
				.toolbar {
					ToolbarItem(placement: .navigationBarLeading) {
						XMarkButton()
					}
				}
			}
		}
	}
	
	private var presentationSection: some View {
		Section(header: Text("Presentation")) {
			VStack(alignment: .leading) {
				Image("logo")
					.resizable()
					.frame(width: 100, height: 100)
					.clipShape(RoundedRectangle(cornerRadius: 20))
				Text("This app was made by a course in youtube. It uses MVVM Architecture, Combine and CoreData!")
					.font(.callout)
					.fontWeight(.medium)
					.foregroundColor(Color.theme.accent)
			}
			.padding(.vertical)
			Link("Subscribe on YT", destination: youtubeUrl)
			Link("Support with a cofee", destination: coffeeUrl)
		}
	}
	
	private var coingeckoSection: some View {
		Section(header: Text("Coin Gecko")) {
			VStack(alignment: .leading) {
				Image("coingecko")
					.resizable()
					.scaledToFit()
					.frame(height: 100)
					.clipShape(RoundedRectangle(cornerRadius: 20))
				Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be sligthly delayed")
					.font(.callout)
					.fontWeight(.medium)
					.foregroundColor(Color.theme.accent)
			}
			.padding(.vertical)
			Link("Visit coingecko", destination: coingeckoUrl)
		}
	}
	
	private var developerSection: some View {
		Section(header: Text("Developer")) {
			VStack(alignment: .leading) {
				Image("logo")
					.resizable()
					.frame(width: 100, height: 100)
					.clipShape(RoundedRectangle(cornerRadius: 20))
				Text("This app was developed By Giovane Barreira. It uses SwiftUI and is written 100% in Swift. The project benefits from  multi-treading, publishers/subscribers, and data persistance.")
					.font(.callout)
					.fontWeight(.medium)
					.foregroundColor(Color.theme.accent)
			}
			.padding(.vertical)
			Link("Visit Linkedin", destination: personalUrl)
		}
	}
	
	private var applicationSection: some View {
		Section(header: Text("Application")) {
			Link("Terms of service", destination: defaultUrl)
			Link("Privacy Policy", destination: defaultUrl)
			Link("Company Website", destination: defaultUrl)
			Link("Learn More", destination: defaultUrl)
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}
