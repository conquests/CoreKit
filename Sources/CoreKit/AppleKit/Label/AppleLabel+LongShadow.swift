//
//  AppleLabel+LongShadow.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 03. 31..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(iOS)

import ObjectiveC.runtime

private var UILabelLongShadowStoreKey: UInt8 = 0

public extension UILabel {

    private var longShadowLayer: CAReplicatorLayer? {
        get {
            return objc_getAssociatedObject(self, &UILabelLongShadowStoreKey) as? CAReplicatorLayer
        }
        set {
            objc_setAssociatedObject(self, &UILabelLongShadowStoreKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func longShadow(_ size: CGFloat) {
        self.longShadowLayer?.removeFromSuperlayer()
        
        let scale = UIScreen.main.scale
        
        let r = CAReplicatorLayer()
        r.instanceCount = Int(size * scale)
        r.instanceColor = UIColor(white: 0.0, alpha: 0.1).cgColor
        r.instanceTransform = CATransform3DMakeTranslation(1.0/scale, 1.0/scale, -1)
        r.instanceAlphaOffset = -0.05 / Float(r.instanceCount)
        r.instanceRedOffset = -0.02
        r.instanceGreenOffset = -0.02
        r.instanceBlueOffset = -0.02
        
        let textLayer = CATextLayer()
        textLayer.foregroundColor = UIColor.yellow.cgColor
        textLayer.contentsScale = scale
        textLayer.rasterizationScale = scale
        textLayer.bounds = self.bounds
        textLayer.anchorPoint = .zero
        textLayer.isWrapped = self.numberOfLines != 1
        
        switch self.textAlignment {
        case .left:
            textLayer.alignmentMode = kCAAlignmentLeft
        case .right:
            textLayer.alignmentMode = kCAAlignmentRight
        case .justified:
            textLayer.alignmentMode = kCAAlignmentJustified
        default:
            textLayer.alignmentMode = kCAAlignmentCenter
        }
        
        switch self.lineBreakMode {
        case .byTruncatingHead:
            textLayer.truncationMode = kCATruncationStart
        case .byTruncatingTail:
            textLayer.truncationMode = kCATruncationEnd
        case .byTruncatingMiddle:
            textLayer.truncationMode = kCATruncationMiddle
        default:
            textLayer.truncationMode = kCATruncationNone
        }
        
        textLayer.font = CTFontCreateWithName(self.font.fontName as CFString, self.font.pointSize, nil)
        textLayer.fontSize = self.font.pointSize
        textLayer.string = self.text
        
        r.addSublayer(textLayer)
        r.position = CGPoint(x: self.frame.minX, y: self.frame.minY)
        self.layer.superlayer?.insertSublayer(r, at: 0)

        self.longShadowLayer = r
    }
    
}

#endif
