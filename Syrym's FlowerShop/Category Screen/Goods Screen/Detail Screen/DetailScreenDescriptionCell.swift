//
//  DetailScreenDescriptionCell.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 08.06.2023.
//

import UIKit

class DetailScreenDescriptionCell: UITableViewCell {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
