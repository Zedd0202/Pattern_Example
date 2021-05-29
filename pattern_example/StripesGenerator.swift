//
//  StripesGenerator.swift
//  pattern_example
//
//  Created by Zedd on 2021/05/29.
//

import UIKit

public class StripesGenerator {
    
    var size: CGSize
    var backgroundColor: UIColor
    var stripeColor: UIColor
    var stripeWidth: CGFloat
    var sharpness: NSNumber
    var angle: CGFloat
    
    let context = CIContext()

    required public init(size: CGSize,
                         backgroundColor: UIColor,
                         stripeColor: UIColor,
                         stripeWidth: CGFloat,
                         sharpness: NSNumber = 1,
                         angle: CGFloat? = nil){
        self.size = size
        self.backgroundColor = backgroundColor
        self.stripeColor = stripeColor
        self.stripeWidth = stripeWidth
        self.sharpness = sharpness
        self.angle = angle ?? .zero
    }
    
    private var stripeFilter: CIFilter? {
        return CIFilter(name: "CIStripesGenerator", parameters: [
            "inputColor0" : CIColor(color: self.stripeColor),
            "inputColor1" : CIColor(color: self.backgroundColor),
            "inputWidth" : self.stripeWidth,
            "inputSharpness": self.sharpness
        ])
    }
    
    private func rotationFilter(inputCIImage: CIImage) -> CIFilter? {
        let inputTransform = NSValue(cgAffineTransform: CGAffineTransform(rotationAngle: self.angle))
        return CIFilter(name: "CIAffineTransform", parameters: [
            "inputImage" : inputCIImage,
            "inputTransform" : inputTransform
        ])
    }
    
    func apply() -> UIImage? {
        guard let stripedCIImage = self.stripeFilter?.outputImage else { return nil }
        if self.angle.isZero {
            return self.createUIImage(from: stripedCIImage)
        } else {
            return createRotatedUIImage(from: stripedCIImage)
        }
    }
    
    private func createUIImage(from ciImage: CIImage) -> UIImage? {
        guard let cgImage = self.createCGImage(ciImage: ciImage) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    private func createCGImage(ciImage: CIImage) -> CGImage? {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        return self.context.createCGImage(ciImage, from: rect)
    }
    
    private func createRotatedUIImage(from ciImage: CIImage) -> UIImage? {
        guard let rotatedImage = self.rotationFilter(inputCIImage: ciImage)?.outputImage,
              let cgImage = self.createCGImage(ciImage: rotatedImage) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
