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
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ARViewContainer(windows: windows)
                .edgesIgnoringSafeArea(.all)
                .navigationDestination(for: Window.self) { window in
                    WindowDetailView(window: window)
                }
                .confirmationDialog("menu", isPresented: $showingMenu, titleVisibility: .hidden) {
                    NavigationLink(destination: IntroductionView()) {
                        Text("introduction")
                    }
                    NavigationLink(destination: ListView()) {
                        Text("list view")
                    }
                    NavigationLink(destination: AboutTheArtistView()) {
                        Text("about the artist")
                    }
                    NavigationLink(destination: BackgroundDetailView()) {
                        Text("backgrounds")
                    }
                    Button {
                        showingInstructions = true
                    } label: {
                        Text("help")
                    }
                }
                .alert(isPresented: $showingInstructions) {
                    Alert(
                        title: Text(Constants.welcomeTitle),
                        message: Text(Constants.welcomeBody),
                        dismissButton: .default(Text("Lets go!"))
                    )
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showingMenu.toggle()
                        } label: {
                            Text("menu")
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
