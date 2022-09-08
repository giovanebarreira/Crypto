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
	
	init () {
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]

	}
	
    var body: some Scene {
        WindowGroup {
					NavigationView {
						HomeView()
							.navigationBarHidden(true)
					}
					.environmentObject(vm)
        }
    }
}
