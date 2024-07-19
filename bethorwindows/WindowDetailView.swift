//
//  WindowDetailView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/12/24.
//

import SwiftUI

struct WindowDetailView: View {
    var body: some View {
        VStack {
            Image("iAmWhatIAm")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 200)
            Text("I Am What I Am")
                .font(.headline)
            Text("The Ark Doors")
                .font(.subheadline)
            Text("""
The Burning Bush is the central theme of the doors of the ark. Just as the right and panels depict creation, the ark doors depict “Revelation,” from the Book of Exodus (3:2) “An angel of the Lord appeared in a blazing fire out of a bush. He gazed and there was a bush all aflame, yet the bush was not consumed.”

The flames cover the entire area and invade the windows on the left and right. They are an extension of the eternal light and the best offering we can give to God the Creator.

The green and blue space at the center of the doors is a remembrance that the bush is never consumed. More emphasis is placed on the flames because red is the color of love.
""")
                .padding()
        }
    }
}

#Preview {
    WindowDetailView()
}
