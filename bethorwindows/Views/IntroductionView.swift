//
//  IntroductionView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/18/24.
//

import SwiftUI

struct IntroductionView: View {
    var body: some View {
        VStack {
            Text("Introduction")
                .titleGotham()
                .padding(.bottom)
            ScrollView {
                VStack(alignment: .leading) {
                    Text(Constants.introduction)
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    IntroductionView()
}
