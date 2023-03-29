//
//  ContentView.swift
//  USDZServer
//
//  Created by Yu Ho Kwok on 24/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var server : WebServer = WebServer()
        
    var body: some View {
        VStack {
            
            
            Circle().fill(server.isRunning ? .green : .red ).frame(width: 30).padding()
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
            
            Text(server.isRunning ? "Server is running" : "Server is not running")
            TextField("Path to Server", text: $server.path)
            
            Button {
                if server.isRunning {
                    server.stop()
                } else {
                    server.start()
                }
                
            } label : {
                Text(server.isRunning ? "Stop" : "Start")
            }
            
            Button {
                server.service.enqueue()
            } label : {
                Text("Enqueue")
            }
         
            ProgressView(value: server.service.progress)
            Text("\(server.service.count)")
            
            
            Button {
                Foundation.exit(0)
            } label : {
                Text("Exit")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
