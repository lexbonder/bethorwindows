//
//  ContentView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/12/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    let windows = Bundle.main.decode("windows.json")
    
    @State private var showingMenu = false
    @State private var showingInstructions = false
    @State private var showingListView = false
    
    var body: some View {
        NavigationStack {
            Group {
                if showingListView {
                    ListView()
                } else {
                    ARViewContainer().edgesIgnoringSafeArea(.all)
                }
            }
            .confirmationDialog("menu", isPresented: $showingMenu, titleVisibility: .hidden) {
                Button("introduction") {}
                Button("backgrounds") {}
                Button("about the artist") {}
            }
            .alert(isPresented: $showingInstructions) {
                Alert(
                    title: Text(Constants.welcomeTitle),
                    message: Text(Constants.welcomeBody),
                    dismissButton: .default(Text("Lets go!"))
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingInstructions = true
                    } label: {
                        Image(systemName: "info")
                            .padding(8)
                            .background(.regularMaterial)
                            .clipShape(.circle)
                            .foregroundStyle(.white)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingListView.toggle()
                    } label: {
                        Text(showingListView ? "Use Camera" : "List View")
                            .padding(8)
                            .background(.regularMaterial)
                            .clipShape(.capsule)
                            .foregroundStyle(.white)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingMenu.toggle()
                    } label: {
                        Text("Menu")
                            .padding(8)
                            .background(.regularMaterial)
                            .clipShape(.capsule)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        // Create a cube model
        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
        let model = ModelEntity(mesh: mesh, materials: [material])
        model.transform.translation.y = 0.05
        
        

        // Create horizontal plane anchor for the content
        let imageAnchor = AnchorEntity(.image(group: "AR Resources", name: "iAmWhatIAmAR"))
//        let anchor = AnchorEntity()
    
//        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        imageAnchor.children.append(model)

        // Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(imageAnchor)

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
