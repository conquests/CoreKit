//
//  AppleLabel+LineSpacing.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 03. 31..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(iOS)

public extension UILabel {
    
    public func setText(text: String, withLineSpacing lineSpacing: CGFloat = 1.0) {
        self.text = nil
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, string.length))
        self.attributedText = string
    }
}

#endif
