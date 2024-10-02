//
//  ListView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/20/24.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Section("Ark Windows") {
                ForEach(viewModel.getArkWindows()) { window in
                    NavigationLink (destination: WindowDetailView(window: window)) {
                        ListItemView(window: window)
                    }
                }
            }
            Section("Above the Ark") {
                ForEach(viewModel.getAboveArkWindows()) { window in
                    NavigationLink (destination: WindowDetailView(window: window)) {
                        ListItemView(window: window)
                    }
                }
            }
            Section("Passover Windows") {
                ForEach(viewModel.getPassoverWindows()) { window in
                    NavigationLink (destination: WindowDetailView(window: window)) {
                        ListItemView(window: window)
                    }
                }
            }
            Section("Around the sanctuary") {
                ForEach(viewModel.getSanctuaryWindows()) { window in
                    NavigationLink (destination: WindowDetailView(window: window)) {
                        ListItemView(window: window)
                    }
                }
            }
        }
    }
}
