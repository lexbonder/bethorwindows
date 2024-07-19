//
//  ContentView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/12/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State private var showingMenu = false
    @State private var showingInstructions = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                ARViewContainer().edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Button {
                            showingInstructions = true
                        } label: {
                            Image(systemName: "info.circle")
                                .font(.title)
                                .background(.ultraThinMaterial)
                                .clipShape(.circle)
                        }
                        Spacer()
                        NavigationLink(destination: WindowDetailView()) {
                            Text("List View")
                        }
                        .padding(10)
                        .background(.thinMaterial)
                        .clipShape(.capsule)
                    }
                    .padding(.horizontal)
                    Spacer()
                    Button("menu") {
                        showingMenu.toggle()
                    }
                }
                .padding()
                .confirmationDialog("menu", isPresented: $showingMenu, titleVisibility: .hidden) {
                    Button("introduction") {}
                    Button("about the artist") {}
                }
                .alert(isPresented: $showingInstructions) {
                    Alert(
                        title: Text("Hello and Welcome!"),
                        message: Text("Aim your camera at any of the stained glass windows within the Gitlin Sanctuary to see their titles. Tap the title to learn more about them."),
                        dismissButton: .default(Text("Lets go!"))
                    )
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
