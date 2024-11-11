//
//  Style-Button.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 11/11/24.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.bethOrBlue)
            .fontWeight(.bold)
            .frame(width: 250, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.bethOrBlue, lineWidth: 2)
            )
            .padding(.vertical, 10)
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(ButtonStyle())
    }
}
