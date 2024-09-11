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
            print("Detected an image anchor!")
            print("Anchor Name: \(imageAnchor.name!)")
            
            // Create a cube model
            let mesh = MeshResource.generateBox(size: 0.4, cornerRadius: 0.005)
            let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
            let model = ModelEntity(mesh: mesh, materials: [material])
            model.transform.translation.y = 0.05
            
            let anchorEntity = AnchorEntity(anchor: imageAnchor)
            anchorEntity.addChild(model)
            
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
