//
//  ContentView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/12/24.
//

import SwiftUI

struct ContentView : View {
    @StateObject var viewModel = ViewModel()
    @StateObject var router = Router.shared
    
    @State private var showingMenu = false
    @State private var showingInstructions = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ARViewContainer(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
                .navigationDestination(for: Window.self) { window in
                    WindowDetailView(window: window)
                }
                .confirmationDialog("Menu", isPresented: $showingMenu, titleVisibility: .hidden) {
                    NavigationLink(destination: IntroductionView()) {
                        Text("Introduction")
                    }
                    NavigationLink(destination: ListView(viewModel: viewModel)) {
                        Text("List view")
                    }
                    NavigationLink(destination: AboutTheArtistView()) {
                        Text("About the artist")
                    }
                    NavigationLink(destination: BackgroundDetailView()) {
                        Text("Backgrounds")
                    }
                    Button {
                        showingInstructions = true
                    } label: {
                        Text("Help")
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
                            Text("Menu")
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                }
        }
    }
}
