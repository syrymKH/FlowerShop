//
//  Banner Struct.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 06.06.2023.
//

import Foundation

struct BannerStruct: Decodable {
    var id: Int
    var name: String
    var picture: String?
    var description: String
}
