//
//  MenuTableViewCell.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 27.05.2023.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewForMenu: UIView!
    @IBOutlet weak var imageForMenu: UIImageView!
    @IBOutlet weak var titleForMenu: UILabel!
    @IBOutlet weak var subtitleForMenu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
