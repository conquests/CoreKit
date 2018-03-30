//
//  Operation+Empty.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

public extension Operation {

    /**
     Executes an operation on the given queue

     - parameter on queue: The operations will be added to this queue
     */
    public static var empty: Operation {
        return BlockOperation(block: {}, completion: nil)
    }
}
