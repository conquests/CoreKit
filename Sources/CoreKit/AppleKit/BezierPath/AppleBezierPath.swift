//
//  AppleBezierPath.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)

    public typealias AppleBezierPath = UIBezierPath

#endif

#if os(macOS)

    public typealias AppleBezierPath = NSBezierPath

    public extension AppleBezierPath {

        public convenience init(arcCenter: CGPoint,
                                radius: CGFloat,
                                startAngle: CGFloat,
                                endAngle: CGFloat,
                                clockwise: Bool) {
            self.init()
            self.appendArc(withCenter: arcCenter,
                           radius: radius,
                           startAngle: startAngle,
                           endAngle: endAngle,
                           clockwise: clockwise)
        }

        public var cgPath: CGPath {
            let path = CGMutablePath()
            var points = [CGPoint](repeating: .zero, count: 3)
            for i in 0 ..< self.elementCount {
                let type = self.element(at: i, associatedPoints: &points)
                switch type {
                case .moveToBezierPathElement: path.move(to: points[0])
                case .lineToBezierPathElement: path.addLine(to: points[0])
                case .curveToBezierPathElement: path.addCurve(to: points[2], control1: points[0], control2: points[1])
                case .closePathBezierPathElement: path.closeSubpath()
                }
            }
            return path
        }
        
        
    }

#endif
