//
//  OrderStruct.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 12.06.2023.
//

import Foundation

struct OrderStruct: Codable {
    var id: Int
    var goods_count: Int = 1
    var phone: String
    var email: String
    var name: String
    var address: String
    var cash: Bool = false
    var note: String
    var sum: String
}

struct OrderResponse: Codable {
    var result: String
    var orderid: String
}

