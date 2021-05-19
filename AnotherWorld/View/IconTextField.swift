//
//  IconTextField.swift
//  AnotherWorld
//
//  Created by Aiden on 26/04/2021.
//

import Foundation
import UIKit


@IBDesignable
class IconTextField: UITextField {
    
    var imageSize: CGSize?
    var imageView: UIImageView?
    
    var textLeftOffset: CGFloat = 0 {
        didSet {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0,
                                                   width: textLeftOffset + 20,
                                                   height: frame.height))
            
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    
    @IBInspectable public var image: UIImage? {
        didSet {
            guard let image = image else { return }
            imageSize = CGSize(width: frame.width/10, height: frame.height/2)
            textLeftOffset = imageSize!.width
            setupImageView(with: image)
            
            
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    
    
    
    fileprivate func setupImageView(with imageObj: UIImage) {
           
           guard let imageSize = imageSize else { return }
           
           imageView = UIImageView()
           imageView!.frame = CGRect(x: 10, y: frame.height/2 - imageSize.height/2, width: imageSize.width, height: imageSize.height)
           imageView!.image = imageObj
           imageView!.contentMode = .scaleAspectFit
           addSubview(imageView!)
    }
    
    func setUpView() {
        clipsToBounds = false
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
}
