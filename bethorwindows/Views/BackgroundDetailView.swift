//
//  BackgroundDetailView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 9/12/24.
//

import SwiftUI

struct BackgroundDetailView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image("asher")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                Image("theHolocaust")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .padding(.horizontal)
                Image("joseph")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            Text("Window backgrounds")
                .titleGotham()
            Text(Constants.windowBackgroundInfo)
                .padding(.horizontal)
            Spacer()
        }
    }
}
