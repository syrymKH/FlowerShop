//
//  BannerTableViewCell.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 06.06.2023.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var backGroundViewForBanner: UIView!
    
    @IBOutlet weak var titleForBanner: UILabel!
    @IBOutlet weak var descriptionForBanner: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
