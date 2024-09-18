//
//  Coordinator.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 9/12/24.
//

import ARKit
import RealityKit

class Coordinator: NSObject, ARSessionDelegate {
    let windows: [Window]
    weak var arView: ARView?
    
    init(windows: [Window], arView: ARView? = nil) {
        self.windows = windows
        self.arView = arView
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let imageAnchor = anchor as? ARImageAnchor else { return }
            
            guard let title = (windows.first { $0.image == anchor.name})?.title else { return }
            print("Detected an image anchor: \(title)")
            
                // Create text model
            let textMesh = MeshResource.generateText(
                title,
                extrusionDepth: 0.01,
                font: .boldSystemFont(ofSize: 0.1),
                containerFrame: .zero,
                alignment: .center,
                lineBreakMode: .byWordWrapping
            )
            let textMaterial = SimpleMaterial(color: .lightGray, isMetallic: true)
            let textModel = ModelEntity(mesh: textMesh, materials: [textMaterial])
            
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
            textModel.position.x -= xHalf
            textModel.position.z -= halfAnchorHeight
            
                // Face title forwards and a little down
            textModel.orientation = simd_quatf(angle: 80 * Float.pi / 180, axis: SIMD3(x: -1, y: 0, z: 0))
            
                // Build anchor entity
            let imageAnchorEntity = AnchorEntity(anchor: imageAnchor)
            imageAnchorEntity.name = anchor.name!
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
        guard let windowToShow = (windows.first{ $0.image == windowImageName}) else { return }
        
        Router.shared.path.append(windowToShow)
    }
}
