//
//  ListView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/20/24.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ViewModel
    
    fileprivate func getWindowDetailsLink(_ window: Window) -> NavigationLink<ListItemView, WindowDetailCarousel<ForEach<[Window], UUID, WindowDetailView>>> {
        return NavigationLink (
            destination: WindowDetailCarousel(startAt: window.windowOrder) {
                ForEach(viewModel.windows) { window in
                    WindowDetailView(window: window)
                }
            },
            label: {
                ListItemView(window: window)
            }
        )
    }
    
    var body: some View {
        List {
            Section("Ark Windows") {
                ForEach(viewModel.getArkWindows()) { window in
                    getWindowDetailsLink(window)
                }
            }
            Section("Above the Ark") {
                ForEach(viewModel.getAboveArkWindows()) { window in
                    getWindowDetailsLink(window)

                }
            }
            Section("Around the sanctuary") {
                ForEach(viewModel.getSanctuaryWindows()) { window in
                    getWindowDetailsLink(window)
                }
            }
        }
    }
}
