//
//  WindowDiagramItem.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 10/28/24.
//

import SwiftUI

struct WindowDiagramItem: Shape {
    let x, y, w, h: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addRect(CGRect(x: x*width, y: y*height, width: w*width, height: h*height))
        return path
    }
}

