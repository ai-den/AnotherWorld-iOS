//
//  LongButton.swift
//  AnotherWorld
//
//  Created by Aiden on 26/04/2021.
//

import Foundation
import UIKit


@IBDesignable
class LongButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderColor: UIColor = .systemBlue
    @IBInspectable var borderWidth: CGFloat = 1
    
    
    override func draw(_ rect: CGRect) {
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}
