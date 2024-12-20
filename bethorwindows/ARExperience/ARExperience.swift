//
//  ARExperience.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 10/30/24.
//

import SwiftUI

struct ARExperience: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    @State private var showingInstructions = false
    
    var body: some View {
        ARViewContainer(viewModel: viewModel)
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $showingInstructions) {
                Alert(
                    title: Text(Constants.augmentedRealityTitle),
                    message: Text(Constants.augmentedRealityDescription),
                    dismissButton: .default(Text("Lets go!"))
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingInstructions.toggle()
                    } label: {
                        Text("Help")
                            .foregroundStyle(.bethOrBlue)
                            .fontWeight(.bold)
                            .padding(10)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
            }
    }
}
