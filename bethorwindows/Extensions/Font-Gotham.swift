//
//  Font-Gotham.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 9/25/24.
//

import SwiftUI

enum FontGothamType: String {
    case bold = "gotham-bold"
}

struct FontGotham: ViewModifier {
    var size: CGFloat = 16
    var type: FontGothamType
    func body(content: Content) -> some View {
        content.font(.custom(type.rawValue, size: size))
    }
}

extension View {
    func titleGotham() -> some View {
        modifier(FontGotham(size: 30, type: .bold))
    }
    
    func subtitleGotham() -> some View {
        modifier(FontGotham(size: 14, type: .bold))
    }
}
