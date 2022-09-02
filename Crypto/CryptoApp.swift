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
