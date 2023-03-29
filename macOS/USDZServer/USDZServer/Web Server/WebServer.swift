//
//  Server.swift
//  USDZServer
//
//  Created by Yu Ho Kwok on 24/11/2022.
//

import Vapor
import Foundation
import Combine

class WebServer : ObservableObject {
    
    @Published var path : String = "~/Downloads/Server/"
    @Published var isRunning = false
    
    
    
    @Published var service : BaseService = DummyService()
                                            //PhotogrammetaryService()
    
    var anyCancellable : AnyCancellable? = nil
    init() {
        anyCancellable = service.objectWillChange.sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    var app : Application? {
        didSet {
            if app == nil {
                DispatchQueue.main.async {
                    self.isRunning = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isRunning = true
                }
            }
        }
    }
    
    var task : Task<(), Never>? {
        didSet {
            if task == nil {
                DispatchQueue.main.async {
                    self.isRunning = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isRunning = true
                }
            }
        }
    }
    
    func start() {
        //self.task =
        Task(priority: .background, operation: {
            do {
                
                let app = try Application(.detect())
                app.directory = DirectoryConfiguration(workingDirectory: path)
                
                //defer { app.shutdown() }
                
                app.get("hello") {
                    req in
                    
                    self.service.enqueue()
                    
                    return "Hello, World."
                }
                
                self.app = app
                try app.run()
                
            } catch {
                self.app?.shutdown()
                self.app = nil
                
//                if self.task?.isCancelled == false {
//                    self.task?.cancel()
//                    self.task = nil
//                }
            }
        })
    }
    
    func stop() {
        if let app = self.app {
            app.shutdown()
            self.app = nil
        }
        
        if self.task?.isCancelled == false {
            print("cancel")
            self.task?.cancel()
            self.task = nil
        }
    }
}
