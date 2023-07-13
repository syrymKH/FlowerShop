//
//  StructInDetailMenu.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 01.06.2023.
//

import Foundation

struct InDetailMenuSectionStruct {
    var titleSection: String?
    var rowsInSection: [InDetailMenuRowsStruct]
}

struct InDetailMenuRowsStruct {
    var title: String
    var subTitle: String
    var image: String?
}
