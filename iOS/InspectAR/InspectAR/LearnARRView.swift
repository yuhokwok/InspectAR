//
//  LearnARView.swift
//  CathayJr
//
//  Created by Cathay Jr. on 19/11/2022.
//

import SwiftUI
import RealityKit

struct LearnARRView : View {
    var body: some View {
        ARRViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARRViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        print("make road")
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Road.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct LearnARRView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
