//
//  ContentView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/12/24.
//

import SwiftUI

struct ContentView : View {
    @StateObject var router = Router.shared
    let windows = Bundle.main.decode("windows.json")
    
    @State private var showingMenu = false
    @State private var showingInstructions = false
    @State private var showingListView = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                if showingListView {
                    ListView()
                } else {
                    ARViewContainer(windows: windows)
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .navigationDestination(for: Window.self) { window in
                WindowDetailView(window: window)
            }
            .confirmationDialog("menu", isPresented: $showingMenu, titleVisibility: .hidden) {
                Button("introduction") {}
                Button("backgrounds") {}
                Button("about the artist") {}
            }
            .alert(isPresented: $showingInstructions) {
                Alert(
                    title: Text(Constants.welcomeTitle),
                    message: Text(Constants.welcomeBody),
                    dismissButton: .default(Text("Lets go!"))
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingInstructions = true
                    } label: {
                        Image(systemName: "info")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("before: ", showingListView)
                        showingListView = !showingListView
                        print("after: ", showingListView)
                    } label: {
                        Text(showingListView ? "Use Camera" : "List View")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingMenu.toggle()
                    } label: {
                        Text("Menu")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
