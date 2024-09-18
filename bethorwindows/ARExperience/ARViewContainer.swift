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
    let windows: [Window]
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let session = arView.session
        let config = ARImageTrackingConfiguration()
        
        config.isAutoFocusEnabled = true
        config.maximumNumberOfTrackedImages = 4
        config.trackingImages = Set(windows.map {
            guard let uiImage = UIImage(named: $0.image) else {
                fatalError("Unable to load UIImage")
            }
            guard let cgImage = uiImage.cgImage else {
                fatalError("Unable to convert UI Image to CGImage")
            }
            let refImage = ARReferenceImage(cgImage, orientation: .up, physicalWidth: 1.07)
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
    
    func updateUIView(_ arView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(windows: windows)
    }
}
