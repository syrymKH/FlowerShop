//
//  BannerTableViewCellImage.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 06.06.2023.
//

import UIKit

class BannerTableViewCellImage: UITableViewCell {

    @IBOutlet weak var backGroundViewForBanner: UIView!
    @IBOutlet weak var imageForBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
