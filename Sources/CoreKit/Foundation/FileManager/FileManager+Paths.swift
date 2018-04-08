//
//  FileManager+Paths.swift
//  CoreKit-iOS
//
//  Created by Tibor Bödecs on 2018. 04. 08..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

import Foundation

public extension FileManager {
    
    public struct Paths {

        public static var document: String {
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        }

        static var cache: String {
            return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        }
    }
}
