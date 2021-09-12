//
//  DiaryCollectionHeader.swift
//  AnotherWorld
//
//  Created by Aiden on 11/08/2021.
//

import UIKit

class DiaryCollectionHeader: UICollectionReusableView {

    @IBOutlet weak var yearTitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        yearTitle.textColor = UIColor(named: K.Colors.primaryAccent)
        locationTitle.textColor = UIColor(named: K.Colors.primary)
    }
    
    func setFonts(forYear yearFont: String, forLocation locationFont: String) {
        
        guard let yearFont = UIFont(name: yearFont, size: 26),
              let locationFont = UIFont(name: locationFont, size: 30) else {
            
            print("Font not found.")
            fatalError()
        }
        yearTitle.font = yearFont
        locationTitle.font = locationFont
    }
    
    
    
}
