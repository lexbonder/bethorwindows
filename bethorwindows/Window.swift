//
//  Window.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/19/24.
//

import Foundation

struct Window: Codable, Identifiable, Hashable {
    let title: String
    let location: String
    let group: String
    let image: String
    let description: String
    let windowOrder: Int
    let dedication: String?
    
    var id: String {
        return self.image
    }
}

