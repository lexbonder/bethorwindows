//
//  ViewModel.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 10/2/24.
//

import ARKit
import SwiftUI
import Supabase

enum Table {
    static let windowDetails = "windowDetails"
    static let windowImages = "windowImages"
}

final class ViewModel: ObservableObject {
    @Published var windows = [Window]()
    
    let saveDataPath = URL.documentsDirectory.appending(path: Table.windowImages)
    
    let supabase = SupabaseClient(
        supabaseURL: Supabase.projectURL,
        supabaseKey: Supabase.anonKey
    )
    
    func fetchWindowDetails() async throws {
        let windowDetails: [Window]
        do {
            let data = try Data(contentsOf: saveDataPath)
            windowDetails = try JSONDecoder().decode([Window].self, from: data)
        } catch {
            windowDetails = try await supabase
                .from(Table.windowDetails)
                .select()
                .execute()
                .value
        }
        
        DispatchQueue.main.async {
            let sortedWindows = windowDetails.sorted { $0.windowOrder <  $1.windowOrder }
            self.windows = sortedWindows
            self.saveData(data: sortedWindows)
        }
    }
    
    func saveData<T: Encodable>(data toSave: [T]) {
        do {
            let data = try JSONEncoder().encode(toSave)
            try data.write(to: saveDataPath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Failed to save data")
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
}
