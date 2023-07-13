//
//  StructMenu.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 27.05.2023.
//

import Foundation
import UIKit

struct MenuStruct {
    var titleForSection: String?
    var section: [MenuSectionStruct]
}

struct MenuSectionStruct {
    var id: Int
    var title: String
    var subTitle: String
    var image: String?
}


