//
//  ARViewContainer.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 9/9/24.
//

import ARKit
import RealityKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let session = arView.session
        let config = ARImageTrackingConfiguration()
        
        config.isAutoFocusEnabled = true
        config.maximumNumberOfTrackedImages = 4
        config.trackingImages = Set(Window.allWindows.map {
            guard let uiImage = UIImage(named: $0.image) else {
                fatalError("Unable to load UIImage")
            }
            guard let cgImage = uiImage.cgImage else {
                fatalError("Unable to convert UI Image to CGImage")
            }
            let refImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: 0.61)
            refImage.name = $0.image
            return refImage
        })
        
        session.run(config, options: [.resetTracking, .removeExistingAnchors])
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .verticalPlane
        arView.addSubview(coachingOverlay)
        
        context.coordinator.arView = arView
        session.delegate = context.coordinator
        
        return arView
    }
    
    func updateUIView(_ arView: ARView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

class Coordinator: NSObject, ARSessionDelegate {
    weak var arView: ARView?
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let imageAnchor = anchor as? ARImageAnchor else { return }
            
            let title = (Window.allWindows.first { $0.image == anchor.name}?.title)!
            print("Detected an image anchor: \(title)")
            
            // Create Text Model
            let textMesh = MeshResource.generateText(title, extrusionDepth: 0.01, font: .boldSystemFont(ofSize: 0.1), containerFrame: .zero, alignment: .center, lineBreakMode: .byWordWrapping)
            let textMaterial = SimpleMaterial(color: .lightGray, isMetallic: true)
            let textModel = ModelEntity(mesh: textMesh, materials: [textMaterial])
            
            // Reposition
            let xHalf = textMesh.bounds.extents.x / 2
            let meshHeight = textMesh.bounds.extents.y
            let halfAnchorHeight = Float(imageAnchor.referenceImage.physicalSize.height) / 2
            textModel.position.x -= xHalf
            textModel.position.z -= halfAnchorHeight
            
            // Face Forwards
            textModel.orientation = simd_quatf(angle: -90, axis: SIMD3(x: 1, y: 0, z: 0))
            
            // Build Anchor Entity
            let anchorEntity = AnchorEntity(anchor: imageAnchor)
            anchorEntity.addChild(textModel)

            // Add to Scene
            arView?.scene.addAnchor(anchorEntity)
        }
        
    }
    
//    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
//        <#code#>
//    }
//
//    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
//        <#code#>
//    }
}
