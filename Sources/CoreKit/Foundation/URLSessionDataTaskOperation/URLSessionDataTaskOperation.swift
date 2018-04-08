//
//  URLSessionDataTaskOperation.swift
//  CoreKit-iOS
//
//  Created by Tibor Bödecs on 2018. 04. 02..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

public typealias URLSessionDataTaskCompletion = (Data?, URLResponse?, Error?) -> Void

open class URLSessionDataTaskOperation: Operation {
    
    private unowned var session: URLSession
    private var request: URLRequest
    private var task: URLSessionDataTask!
    
    private var _finished: Bool = false
    private var _executing: Bool = false
    
    open override var isFinished: Bool {
        return self._finished
    }
    
    open override var isExecuting: Bool {
        return self._executing
    }

    #if !os(Linux)
    open override var isConcurrent: Bool {
        return true
    }
    #endif
    
    public init(session: URLSession, request: URLRequest, completion: @escaping URLSessionDataTaskCompletion) {
        self.session = session
        self.request = request
        
        super.init()
        
        self.task = session.dataTask(with: request) { [weak self] data, response, error in
            self?.completeOperation(block: completion, data: data, response: response, error: error)
        }
    }
    
    open override func cancel() {
        super.cancel()
        self.task.cancel()
    }
    
    open override func start() {
        if self.isCancelled {
            return self.changingValueFor(key: "isFinished", block: {
                self._finished = true
            })
        }
        
        return self.changingValueFor(key: "isExecuting", block: {
            self.task.resume()
            self._executing = true
        })
    }
    
    // MARK: - helpers
    
    private func changingValueFor(key: String, block: VoidBlock) {
        self.willChangeValue(forKey: key)
        block()
        self.didChangeValue(forKey: key)
    }
    
    private func completeOperation() {
        guard self._executing && !self._finished else {
            return
        }
        
        self.willChangeValue(forKey: "isFinished")
        self.willChangeValue(forKey: "isExecuting")
        
        self._executing = false
        self._finished  = true
        
        self.didChangeValue(forKey: "isFinished")
        self.didChangeValue(forKey: "isExecuting")
    }
    
    private func completeOperation(block: URLSessionDataTaskCompletion,
                                   data: Data?,
                                   response: URLResponse?,
                                   error: Error?) {
        if !self.isCancelled {
            block(data, response, error)
        }
        self.completeOperation()
    }
}
