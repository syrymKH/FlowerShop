//
//  DetailScreenImageCell.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 08.06.2023.
//

import UIKit

class DetailScreenImageCell: UITableViewCell {

    @IBOutlet weak var backGroundViewForImage: UIView!
    @IBOutlet weak var pictureForImageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
