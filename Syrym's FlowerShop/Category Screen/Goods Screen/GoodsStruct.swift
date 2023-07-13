//
//  StructGoods.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 02.06.2023.
//

import Foundation

struct GoodsStruct: Decodable {
    var id: Int
    var id_section: Int
    var name: String
    var picture: String?
    var price: String
    var description: String
}
