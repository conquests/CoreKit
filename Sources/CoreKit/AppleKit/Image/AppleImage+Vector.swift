//
//  AppleImage+Vector.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

public extension AppleImage {

    public static func vectorImage(named: String, _ scale: Int = 48) -> AppleImage? {
        return AppleImage.vectorImage(named: named, size: CGSize(width: scale, height: scale))
    }

    public static func vectorImage(named: String, size: CGSize = CGSize(width: 48, height: 48)) -> AppleImage? {
        #if os(macOS)
        guard
            let url = AppleBundle.main.url(forResource: named, withExtension: "pdf"),
            let pdf = NSPDFImageRep.imageReps(withContentsOf: url)?.first as? NSPDFImageRep
        else {
            return nil
        }
        pdf.currentPage = 0
        return AppleImage(size: size, flipped: false) { rect in
            pdf.draw(in: rect)
            return true
        }
        #else
        guard
            let url = AppleBundle.main.url(forResource: named, withExtension: "pdf"),
            let pdf = CGPDFDocument(url as CFURL)
        else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let page = pdf.page(at: 1)
        page?.drawContextIn(rect: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
        #endif
    }
}
