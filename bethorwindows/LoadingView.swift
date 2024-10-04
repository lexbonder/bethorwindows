//
//  LoadingView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 10/4/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color("LaunchScreenColor")
                .ignoresSafeArea()
            VStack {
                Image("menorahIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                ProgressView()
                Text("Loading...")
            }
        }
    }
}

#Preview {
    LoadingView()
}
