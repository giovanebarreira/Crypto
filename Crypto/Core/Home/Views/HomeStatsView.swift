//
//  HomeStatsView.swift
//  Crypto
//
//  Created by Giovane Barreira on 02/09/22.
//

import SwiftUI

struct HomeStatsView: View {
	@EnvironmentObject private var vm: HomeViewModel
	@Binding var showPortifolio: Bool
	
    var body: some View {
			HStack {
				ForEach(vm.statistics) { stat in
					StatisticView(stat: stat)
						.frame(width: UIScreen.main.bounds.width / 3)
				}
			}
			.frame(width: UIScreen.main.bounds.width,
						 alignment: showPortifolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
			HomeStatsView(showPortifolio: .constant(false))
				.environmentObject(dev.homeVM)
    }
}
