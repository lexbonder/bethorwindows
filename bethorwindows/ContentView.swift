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
    @State private var showsError = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ContentPrepareView(viewModel: viewModel) {
                ListView(viewModel: viewModel)
                    .navigationDestination(for: Window.self) { window in
                        WindowDetailCarousel(startAt: window.windowOrder) {
                            ForEach(viewModel.windows) { vmWindow in
                                WindowDetailView(window: vmWindow)
                            }
                        }
                    }
                    .confirmationDialog("Menu", isPresented: $showingMenu, titleVisibility: .hidden) {
                        NavigationLink(destination: IntroductionView()) {
                            Text("Introduction")
                        }
                        NavigationLink(destination: AboutTheArtistView()) {
                            Text("About the artist")
                        }
                        NavigationLink(destination: BackgroundDetailView(viewModel: viewModel)) {
                            Text("Backgrounds")
                        }
                        NavigationLink(destination: ARExperience(viewModel: viewModel)) {
                            Text("Augmented Reality 📷")
                        }
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
            } task: {
                try await viewModel.fetchWindowDetails()
                guard showsError else { return }
                showsError = false
                throw LoadingError.contentFailed
            }
        }
    }
}

enum LoadingError: LocalizedError {
    case contentFailed
    
    var contentErrorDescription: String? {
        "Window details failed to load."
    }
}
