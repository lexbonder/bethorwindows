//
//  WindowDiagramView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 10/28/24.
//

import SwiftUI

struct WindowDiagramView: View {
    let activeWindow: Int
    
    var body: some View {
        ZStack {
            ForEach(diagramItemList) { item in
                WindowDiagramItem(x: item.x, y: item.y, w: item.width, h: item.height)
                    .foregroundStyle(activeWindow == item.id ? .bethOrOrange : .bethOrBlue)
            }
        }
        .frame(width: 200, height: 100)
    }
}
