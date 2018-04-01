//
//  AppleLabel+Height.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 03. 31..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(iOS)

public extension UILabel {
    
    /**
     Calculates the height of the label for a given width, font, and text
     
     - parameter width: The width to fit in
     - parameter font:  The font used to display the text
     - parameter text:  The text to display
     
     - returns: The height needed to display
     */
    public class func height(forWidth width: CGFloat, font: UIFont, text: String) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let label = UILabel(frame: CGRect(origin: .zero, size: size))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
}

#endif
