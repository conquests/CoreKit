//
//  FloatingPoint+Random.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

public extension FloatingPoint {

    /**
     Randomize a floating point number

     - returns: A random value between 0 and 1
     */
    public static var random: Self {
        return self.init(rndm(to: Int.max)) / self.init(Int.max)
    }
}
