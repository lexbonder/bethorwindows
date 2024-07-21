//
//  Window.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/19/24.
//

import Foundation

struct Window: Codable, Identifiable {
    let title: String
    let location: String
    let group: String
    let image: String
    let description: String
    
    var id: String {
        return self.image
    }
    
    static let allWindows: [Window] = Bundle.main.decode("windows.json")
    static let arkWindows = allWindows.filter { $0.group == "ark" }
    static let aboveArkWindows = allWindows.filter { $0.group == "aboveArk" }
    static let sanctuaryWindows = allWindows.filter { $0.group == "sancutary" }
    static let passoverWindows = allWindows.filter { $0.group == "passover" }
    static let example = allWindows[2]
}

