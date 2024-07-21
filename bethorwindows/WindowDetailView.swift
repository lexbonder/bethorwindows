//
//  WindowDetailView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/12/24.
//

import SwiftUI

struct WindowDetailView: View {
    let window: Window
    
    var body: some View {
        VStack {
            Image(window.image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 200)
            Text(window.title)
                .font(.title)
            Text(window.location)
                .font(.subheadline)
            ScrollView {
                Text(window.description)
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    WindowDetailView(window: Window.example)
}
