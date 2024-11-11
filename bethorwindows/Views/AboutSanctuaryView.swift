//
//  IntroductionView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/18/24.
//

import SwiftUI

struct AboutSanctuaryView: View {
    var body: some View {
        VStack {
            Text("About our Sanctuary")
                .titleGotham()
                .padding(.bottom)
            ScrollView {
                VStack(alignment: .leading) {
                    Text(.init(Constants.aboutSanctuary))
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}
