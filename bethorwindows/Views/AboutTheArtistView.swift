//
//  AboutTheArtistView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 9/12/24.
//

import SwiftUI

struct AboutTheArtistView: View {
    var body: some View {
        VStack {
            Image("benoit")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 200)
            Text(Constants.artistName)
                .titleGotham()
                .padding(.bottom)
            ScrollView {
                VStack(alignment: .leading) {
                    Text(Constants.artistAbout)
                        .padding(.bottom)
                    Text(Constants.artistQuote)
                        .italic()
                        .padding(.leading, 20)
                        .padding(.bottom)
                    Text(Constants.artistObit)
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}
