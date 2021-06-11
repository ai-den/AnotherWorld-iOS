//
//  Attraction.swift
//  AnotherWorld
//
//  Created by Aiden on 21/05/2021.
//

import Foundation
import UIKit

struct Attraction {
    var name: String
    var address: String
    var placeID: String
    var image: UIImage?
    
    init() {
        name = "Null"
        address = "Null"
        placeID = "Null"
        
    }
    
    init(name: String, address: String, placeID: String, image: UIImage?) {
        self.name = name
        self.address = address
        self.placeID = placeID
        self.image = image
    }
    
}
