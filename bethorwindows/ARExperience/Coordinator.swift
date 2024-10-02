//
//  Coordinator.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 9/12/24.
//

import SwiftUI
import ARKit
import RealityKit

class Coordinator: NSObject, ARSessionDelegate {
    @ObservedObject var viewModel: ViewModel
    weak var arView: ARView?
    
    init(viewModel: ViewModel, arView: ARView? = nil) {
        self.viewModel = viewModel
        self.arView = arView
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let imageAnchor = anchor as? ARImageAnchor else { return }
            guard let window = (viewModel.windows.first { $0.image == anchor.name}) else { return }
            let title = window.title
            print("Detected an image anchor: \(title)")
            
                // Create text model
            let textMesh = MeshResource.generateText(
                title,
                extrusionDepth: 0.01,
                font: UIFont(name: FontGothamType.bold.rawValue, size: 0.1) ?? .boldSystemFont(ofSize: 0.1),
                containerFrame: .zero,
                alignment: .center,
                lineBreakMode: .byWordWrapping
            )
            let textMaterial = UnlitMaterial(color: .white)
            let textModel = ModelEntity(mesh: textMesh, materials: [textMaterial])
            
                // Create text background
            let textBackgroundMesh = MeshResource.generatePlane(
                width: textMesh.bounds.extents.x + 0.035,
                height: textMesh.bounds.extents.y + 0.035,
                cornerRadius: 0.02
            )
            
            let textBackgroundMaterial = UnlitMaterial(color: .black)
            let textBackgroundModel = ModelEntity(mesh: textBackgroundMesh, materials: [textBackgroundMaterial])
            textBackgroundModel.orientation = simd_quatf(angle: 90 * Float.pi / 180, axis: SIMD3(x: -1, y: 0, z: 0))

                // Create overlay
            let imageOverlay = ModelEntity(
                mesh: MeshResource.generatePlane(
                    width: Float(imageAnchor.referenceImage.physicalSize.width),
                    height: Float(imageAnchor.referenceImage.physicalSize.height)),
                materials: [SimpleMaterial(color: .clear, isMetallic: true)])
            
                // Lay it flat on top of image
            imageOverlay.orientation = simd_quatf(angle: 90 * Float.pi / 180, axis: SIMD3(x: -1, y: 0, z: 0))
            
                // Reposition title
            let xHalf = textMesh.bounds.extents.x / 2
            let halfAnchorHeight = Float(imageAnchor.referenceImage.physicalSize.height) / 2
            let halfTextHeight = textMesh.bounds.extents.y / 2
            textModel.position.x -= xHalf

            if (window.group == "ark") {
                textBackgroundModel.position.z -= halfTextHeight + 0.0125
            } else {
                textModel.position.z -= halfAnchorHeight - textBackgroundMesh.bounds.extents.y
                textBackgroundModel.position.z -= halfAnchorHeight - (halfTextHeight + 0.0125)
            }

            
                // Face title forwards and a little down
            textModel.orientation = simd_quatf(angle: 90 * Float.pi / 180, axis: SIMD3(x: -1, y: 0, z: 0))
            
                // Build anchor entity
            let imageAnchorEntity = AnchorEntity(anchor: imageAnchor)
            imageAnchorEntity.name = anchor.name!
            imageAnchorEntity.addChild(textBackgroundModel)
            imageAnchorEntity.addChild(textModel)
            imageAnchorEntity.addChild(imageOverlay)
            
                // Make entities tappable
            textModel.generateCollisionShapes(recursive: true)
            imageOverlay.generateCollisionShapes(recursive: true)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            arView?.addGestureRecognizer(tapGesture)
            
                // Add to Scene
            arView?.scene.addAnchor(imageAnchorEntity)
        }
    }
    
    @objc
    func handleTap(_ recognizer: UITapGestureRecognizer? = nil) {
        guard let touchInView = recognizer?.location(in: arView) else { return }
        
        guard let modelEntity = arView?.entity(at: touchInView) as? ModelEntity else {
            print("modelEntity not found")
            return
        }
        
        guard let windowImageName = modelEntity.anchor?.name else { return }
        guard let windowToShow = (viewModel.windows.first{ $0.image == windowImageName}) else { return }
        
        Router.shared.path.append(windowToShow)
    }
}
