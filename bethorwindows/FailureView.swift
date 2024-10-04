//
//  FailureView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 10/4/24.
//

import SwiftUI

struct FailureView: View {
    let error: Error
    let retryTask: () async -> Void
    
    var body: some View {
        ContentUnavailableView(label: {
            Label("Failed to load", systemImage: "exclamationmark.circle.fill")
        }, description: {
            Text(error.localizedDescription)
        }, actions: {
            Button(action: {
                Task { await retryTask() }
            }, label: {
                Text("Retry")
            })
        })
    }
}
