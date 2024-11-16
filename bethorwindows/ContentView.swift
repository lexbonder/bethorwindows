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
    
    @State private var showsError = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ContentPrepareView(viewModel: viewModel) {
                ScrollView {
                    Image("creation")
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text(Constants.introWelcome)
                            .titleGotham()
                        
                        Text(Constants.introWelcomeHebrew)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 15)

                    
                    Text(Constants.introDescription)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: AboutSanctuaryView()) {
                        Text("About The Gitlin Sanctuary")
                            .buttonStyle()
                    }
                    
                    NavigationLink(destination: ListView(viewModel: viewModel)) {
                        Text("Windows")
                            .buttonStyle()
                    }
                    
                    NavigationLink(destination: ARExperience(viewModel: viewModel)) {
                        Text("Augmented Reality")
                            .buttonStyle()
                    }
                    .navigationDestination(for: Window.self) { window in
                        if #available(iOS 18, *) {
                            WindowDetailCarousel(startAt: window.windowOrder) {
                                ForEach(viewModel.windows) { vmWindow in
                                    WindowDetailView(window: vmWindow)
                                }
                            }
                        } else {
                            WindowDetailView(window: window)
                        }
                    }
                    
                    NavigationLink(destination: AboutTheArtistView()) {
                        Text("About the artist")
                            .buttonStyle()
                    }
                    
                    Text(Constants.introAppCredit)
                        .padding()
                        .font(.custom("gotham-light", size: 14))
                        .multilineTextAlignment(.center)
                }
            }
            task: {
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
