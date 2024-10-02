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
    @ObservedObject var viewModel: ViewModel
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        context.coordinator.arView = arView
        arView.session.delegate = context.coordinator
        
        return arView
    }
    
    func updateUIView(_ arView: ARView, context: Context) {
        if (viewModel.windows.isNotEmpty && !viewModel.trackingImagesLoaded) {
            let session = arView.session
            let config = ARImageTrackingConfiguration()
            
            config.isAutoFocusEnabled = true
            config.maximumNumberOfTrackedImages = 4
            config.trackingImages = Set(viewModel.windows.map {
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
            viewModel.setTrackingImagesLoaded()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
}
