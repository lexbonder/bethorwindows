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
            Text(Constants.artistName)
                .font(.title)
                .padding(.bottom)
            Text(Constants.aboutTheArtist)
                .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    AboutTheArtistView()
}
