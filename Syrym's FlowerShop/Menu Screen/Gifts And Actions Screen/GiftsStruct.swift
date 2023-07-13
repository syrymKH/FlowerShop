//
//  GiftsStruct.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 03.06.2023.
//

import Foundation

struct GiftsStruct: Decodable {
    var id: Int
    var name: String
    var picture: String?
    var description: String
}

