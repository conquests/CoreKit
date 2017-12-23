//
//  Bool+Random.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

public extension Bool {
    /**
     Generates a random bool value

     - returns: The random true or false value
     */
    public static var random: Bool {
        return rndm(to: 1) == 1
    }
}
