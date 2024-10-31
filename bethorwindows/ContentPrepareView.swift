//
//  ContentPrepareView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 10/4/24.
//

import SwiftUI

struct ContentPrepareView<Content, Failure, Loading>: View where Content: View, Failure: View, Loading: View {
    @State private var viewContent: ViewContent = .loading
    
    @ViewBuilder let content: () -> Content
    @ViewBuilder let failure: (Error, @escaping () async -> Void) -> Failure
    @ViewBuilder let loading: () -> Loading
    
    @ObservedObject var viewModel: ViewModel
    let task: () async throws -> Void
    
    init(
        viewModel: ViewModel,
        content: @escaping () -> Content,
        failure: @escaping (Error, @escaping () async -> Void) -> Failure = { FailureView(error: $0, retryTask: $1) },
        loading: @escaping () -> Loading = { LoadingView() },
        task: @escaping () async throws -> Void
    ) {
        self.viewModel = viewModel
        self.content = content
        self.failure = failure
        self.loading = loading
        self.task = task
    }
    
    var body: some View {
        Group {
            switch viewContent {
            case .content:
                content()
            case .failure(let error):
                failure(error, loadTask)
            case .loading:
                loading()
            }
        }
        .onLoad(perform: loadTask)
    }
    
    @MainActor func loadTask() async {
        do {
            viewContent = .loading
            try await task()
            viewContent = .content
        } catch {
            viewContent = .failure(error)
        }
    }
}
