//
//  imageWithText.swift
//  Picker
//
//  Created by Chuck Deerinck on 6/21/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

func imageWithText(text:String, fontSize:CGFloat = 150, fontColor:UIColor = .black, imageSize:CGSize, backgroundColor:UIColor) -> UIImage? {

    let imageRect = CGRect(origin: CGPoint.zero, size: imageSize)
    UIGraphicsBeginImageContext(imageSize)
    defer { UIGraphicsEndImageContext() }
    guard let context = UIGraphicsGetCurrentContext() else { return nil }

    // Fill the background with a color
    context.setFillColor(backgroundColor.cgColor)
    context.fill(imageRect)

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center

    // Define the attributes of the text
    let attributes = [
        NSAttributedString.Key.font: UIFont(name: "Zapfino", size:fontSize),
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.foregroundColor: fontColor
    ]

    // Determine the width/height of the text for the attributes
    let textSize = text.size(withAttributes: attributes as [NSAttributedString.Key : Any])

    // Draw text in the current context
    text.draw(at: CGPoint(x: imageSize.width/2 - textSize.width/2, y: imageSize.height/2 - textSize.height/2), withAttributes: attributes as [NSAttributedString.Key : Any])

    if let image = UIGraphicsGetImageFromCurrentImageContext() {
        return image
    }
    return nil
}
