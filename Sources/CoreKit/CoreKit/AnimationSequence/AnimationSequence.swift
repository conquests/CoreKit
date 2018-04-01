//
//  AnimationSequence.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 03. 24..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(iOS)

public class AnimationSequence {

    public struct Item {
        public let duration: TimeInterval
        public let curve: UIViewAnimationCurve
        public let animation: VoidBlock
        public let completion: VoidBlock?

        public init(duration: TimeInterval,
                    animation: @escaping VoidBlock,
                    curve: UIViewAnimationCurve,
                    completion: VoidBlock? = nil) {
            self.duration = duration
            self.animation = animation
            self.curve = curve
            self.completion = completion
        }
    }
    
    public let duration: TimeInterval
    public let delay: TimeInterval
    public let completion: VoidBlock?

    private var sequence: [Item] = []
    public private(set) var isRunning: Bool
    private var isFirst: Bool
    
    public init(duration: TimeInterval, delay: TimeInterval = 0, completion: VoidBlock?) {
        self.duration = duration
        self.delay = 0
        self.completion = completion
        
        self.sequence = []
        self.isRunning = false
        self.isFirst = true
    }

    public func add(_ animation: Item) {
        self.sequence.append(animation)
    }

    public func start() {
        self.isRunning = true
        self.performNextAnimation()
    }

    private func performNextAnimation() {
        guard !self.sequence.isEmpty else {
            self.isRunning = false
            self.completion?()
            return
        }

        let item = self.sequence.removeFirst()
        let duration = item.duration * self.duration
        let options = UIViewAnimationOptions(rawValue: UInt(item.curve.rawValue << 16))
        let delay: TimeInterval = self.isFirst ? self.delay : 0

        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: options,
                       animations: item.animation) { _ in
            item.completion?()
            self.isFirst = false
            self.performNextAnimation()
        }
    }
}

#endif
