//
//  ListView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/20/24.
//

import SwiftUI

struct ListView: View {
    let windows = Window.allWindows
    
    var body: some View {
        List {
            Section("Ark Windows") {
                ForEach(Window.arkWindows) { window in
                    NavigationLink (destination: WindowDetailView(window: window)) {
                        ListItemView(window: window)
                    }
                }
            }
            Section("Above the Ark") {
                ForEach(Window.aboveArkWindows) { window in
                    NavigationLink (destination: WindowDetailView(window: window)) {
                        ListItemView(window: window)
                    }
                }
            }
            Section("Passover Windows") {
                ForEach(Window.passoverWindows) { window in
                    NavigationLink (destination: WindowDetailView(window: window)) {
                        ListItemView(window: window)
                    }
                }
            }
            Section("Around the sanctuary") {
                ForEach(Window.sanctuaryWindows) { window in
                    NavigationLink (destination: WindowDetailView(window: window)) {
                        ListItemView(window: window)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListView()
    }
}
