//
//  LearnARView.swift
//  CathayJr
//
//  Created by Cathay Jr. on 19/11/2022.
//

import SwiftUI
import RealityKit

struct LearnARView : View {
    @Binding var arCode : Int
    var body: some View {
        ARViewContainer(arCode: self.arCode).edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    var arCode : Int
    
    func makeUIView(context: Context) -> ARView {
        
        print("make experience: \(arCode)")
        
        let arView = ARView(frame: .zero)
        
        switch arCode {
        case 0:
            // Load the "Box" scene from the "Experience" Reality File
            let anchor = try! Experience.loadBox()
            // Add the box anchor to the scene
            arView.scene.anchors.append(anchor)
        case 1:
            // Load the "Box" scene from the "Experience" Reality File
            let anchor = try! IVE.loadBox()
            // Add the box anchor to the scene
            arView.scene.anchors.append(anchor)
        case 10:
            // Load the "Box" scene from the "Experience" Reality File
            let anchor = try! Road.loadBox()
            // Add the box anchor to the scene
            arView.scene.anchors.append(anchor)
        
        case 11:
            // Load the "Box" scene from the "Experience" Reality File
            let anchor = try! Lab.loadBox()
            // Add the box anchor to the scene
            arView.scene.anchors.append(anchor)
        case 12:
            // Load the "Box" scene from the "Experience" Reality File
            let anchor = try! Dino.loadBox()
            // Add the box anchor to the scene
            arView.scene.anchors.append(anchor)
        default:
            // Load the "Box" scene from the "Experience" Reality File
            let anchor = try! Road.loadBox()
            // Add the box anchor to the scene
            arView.scene.anchors.append(anchor)
        }
        
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct LearnARView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
