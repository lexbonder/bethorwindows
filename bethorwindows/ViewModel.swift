//
//  ViewModel.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 10/2/24.
//

import SwiftUI
import Supabase

enum Table {
    static let windowDetails = "windowDetails"
}

final class ViewModel: ObservableObject {
    @Published var windows = [Window]()
    @Published var trackingImagesLoaded = false
    
    let supabase = SupabaseClient(
        supabaseURL: Supabase.projectURL,
        supabaseKey: Supabase.anonKey
    )
    
    func fetchWindowDetails() async throws {
        let windowDetails: [Window] = try await supabase
            .from(Table.windowDetails)
            .select()
            .execute()
            .value
        
        DispatchQueue.main.async {
            self.windows = windowDetails.sorted { $0.windowOrder <  $1.windowOrder }
        }
    }
    
    func getArkWindows() -> [Window] {
        return windows.filter { $0.group == "ark" }
    }
    
    func getAboveArkWindows() -> [Window] {
        return windows.filter { $0.group == "aboveArk" }
    }
    
    func getSanctuaryWindows() -> [Window] {
        return windows.filter { $0.group == "sancutary" }
    }
    
    func setTrackingImagesLoaded() {
        DispatchQueue.main.async {
            self.trackingImagesLoaded = true
        }
    }
}
