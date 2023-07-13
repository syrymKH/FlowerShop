//
//  GiftsSpecialActionsTableViewCell.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 03.06.2023.
//

import UIKit

class GiftsSpecialActionsTableViewCell: UITableViewCell {

    @IBOutlet weak var giftsBackgroundView: UIView!
    @IBOutlet weak var giftsImage: UIImageView!
    @IBOutlet weak var giftsTitle: UILabel!
    @IBOutlet weak var giftsDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
