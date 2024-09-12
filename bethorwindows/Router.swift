//
//  Router.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 9/12/24.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    static let shared: Router = Router()
}
