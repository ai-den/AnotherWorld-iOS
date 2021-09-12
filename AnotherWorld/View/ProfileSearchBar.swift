//
//  ProfileSearchBar.swift
//  AnotherWorld
//
//  Created by Aiden on 02/05/2021.
//

import Foundation
import UIKit


public class ProfileSearchBar: UIView {
    public var leftIcon: UIButton!
    public var textInput: UITextField!
    public var rightIcon: UIButton!
    private var stackView: UIStackView!
    
    // =========================================
    // MARK: - Public Properties
    // =========================================
    public var cornerRadius: CGFloat = 10.0
    public var borderWidth: CGFloat = 1.0
    public var borderColor: UIColor = .lightGray
    public var searchbarHint = "Search Attraction"
    public var foregroundColor: UIColor = .darkGray
    public var imgLeftBtn: UIImage = UIImage(systemName: "magnifyingglass")!
    
    
    // =========================================
    // MARK: - Delegate variable
    // =========================================
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    
    
    private func setUpUI() {
        self.backgroundColor = .white
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        textInput = UITextField()
        textInput.placeholder = searchbarHint
        textInput.textColor = foregroundColor
        textInput.backgroundColor = .white
        textInput.returnKeyType = .search
        
        leftIcon = UIButton()
        leftIcon.setImage(imgLeftBtn, for: .normal)
        leftIcon.backgroundColor = .white
        
        rightIcon = UIButton()
        rightIcon.setImage(UIImage(systemName: "person.fill"), for: .normal)
        rightIcon.backgroundColor = .white
        
        stackView = UIStackView(arrangedSubviews: [leftIcon, textInput, rightIcon])
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0.0).isActive = true
//        stackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0.0).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftIcon.widthAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.8).isActive = true
        rightIcon.widthAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
}
