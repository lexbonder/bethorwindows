//
//  ARExperience.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 10/30/24.
//

import SwiftUI

struct ARExperience: View {
    @ObservedObject var viewModel: ViewModel
    @State private var showingInstructions = false
    
    var body: some View {
        ARViewContainer(viewModel: viewModel)
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $showingInstructions) {
                Alert(
                    title: Text(Constants.welcomeTitle),
                    message: Text(Constants.welcomeBody),
                    dismissButton: .default(Text("Lets go!"))
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingInstructions.toggle()
                    } label: {
                        Text("Help")
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
            }
    }
}
