//
//  DummyService.swift
//  USDZServer
//
//  Created by Yu Ho Kwok on 24/11/2022.
//

import Foundation

class  BaseService : ObservableObject {
    
    var operationQueue : OperationQueue = OperationQueue()
    
    init () {
        self.operationQueue.maxConcurrentOperationCount = 1
    }
    
    @Published var progress : Double = 1
    @Published var tasks : [String] = []
    @Published var count : Int = 0
    func enqueue() {
        print("max: \(self.operationQueue.maxConcurrentOperationCount)")
        self.operationQueue.addOperation({
        
            Task {
                let uuid = UUID().uuidString
                print("run: \(uuid)")
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                print("finished: \(uuid)")
            }
            
        })
//        self.operationQueue.addBarrierBlock {
//            Task {
//                let uuid = UUID().uuidString
//                print("run: \(uuid)")
//                try? await Task.sleep(nanoseconds: 3_000_000_000)
//                print("finished: \(uuid)")
//            }
//        }
        
    }
}

class DummyService : BaseService {
    //@Published var tasks : [String] = []
    
    
    override func enqueue() {
        super.enqueue()
//        print("enqueue")
//        DispatchQueue.main.async {
//            self.tasks.append("hihi")
//            self.count = self.tasks.count
//            print("\(self.tasks.count)")
//        }
    }
    
    
    
}
