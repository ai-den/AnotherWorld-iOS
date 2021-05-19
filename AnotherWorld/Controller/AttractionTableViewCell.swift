//
//  FavoriteTableViewCell.swift
//  AnotherWorld
//
//  Created by Aiden on 13/05/2021.
//

import UIKit

class AttractionTableViewCell: UITableViewCell {

    @IBOutlet weak var attractionTitle: UILabel!
    @IBOutlet weak var attractionLocation: UILabel!
    @IBOutlet weak var attractionImage: UIImageView!
    @IBOutlet weak var attractionStatus: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        guard attractionStatus != nil else {
//            attractionStatus.text = ""
//            return
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
