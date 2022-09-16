//
//  CryptoApp.swift
//  Crypto
//
//  Created by Giovane Barreira on 30/08/22.
//

import SwiftUI

@main
struct CryptoApp: App {
	
	@StateObject private var vm = HomeViewModel()
	@State private var showLaunchView: Bool = true
	
	init () {
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
		UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
		UITableView.appearance().backgroundColor = UIColor.clear
	}
	
	var body: some Scene {
		WindowGroup {
			ZStack {
				NavigationView {
					HomeView()
						.navigationBarHidden(true)
				}
				.navigationViewStyle(.stack)
				.environmentObject(vm)
				
				// Workaround to not mess with zIndex in launch animation
				ZStack {
					if showLaunchView {
						LaunchView(showLaunchView: $showLaunchView)
							.transition(.move(edge: .leading))
					}
				}
				.zIndex(2.0)
			}
		}
	}
}
