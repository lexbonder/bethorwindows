//
//  ListItemView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/20/24.
//

import SwiftUI

struct ListItemView: View {
    let window: Window
    
    var body: some View {
        HStack (spacing: 20) {
            Image(window.image)
                .resizable()
                .frame(width: 50, height: 50)
                .scaledToFit()
//            AsyncImage(url: URL(string: window.imageUrl)) { image in
//                image
//                    .resizable()
//                    .scaledToFit()
//            } placeholder: {
//                ZStack {
//                    Image("menorahIcon")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 50, height: 50)
//                        .grayscale(1)
//                    ProgressView()
//                }
//            }
//            .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(window.title)
                    .titleGotham()
            }
        }
    }
}
