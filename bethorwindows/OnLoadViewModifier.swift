//
//  OnLoadViewModifier.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 10/4/24.
//

import SwiftUI

struct OnLoadViewModifier: ViewModifier {
    @State private var hasPrepared = false
    @State private var task: Task<Void, Never>?
    let action: (() async -> Void)
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !hasPrepared else { return }
                guard task == nil else { return }
                task = Task {
                    await action()
                    hasPrepared.toggle()
                }
            }
            .onDisappear {
                task?.cancel()
                task = nil
            }
    }
}

public extension View {
    func onLoad(perform action: @escaping () async -> Void) -> some View {
        modifier(OnLoadViewModifier(action: action))
    }
}
