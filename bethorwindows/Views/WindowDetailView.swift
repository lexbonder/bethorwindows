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
                .titleGotham()
            Text(window.location)
                .subtitleGotham()
            ScrollView {
                VStack(alignment: .leading) {
                    Text("About:")
                        .fontWeight(.bold)
                    Text(window.description)
                    if let dedication = window.dedication {
                        Text("Dedication:")
                            .padding(.top)
                            .fontWeight(.bold)
                        Text(dedication)
                    }
                }
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    WindowDetailView(window: Window.allWindows[8])
}
