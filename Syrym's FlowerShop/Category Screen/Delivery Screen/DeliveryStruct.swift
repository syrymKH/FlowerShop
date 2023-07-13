//
//  DeliveryStruct.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 01.07.2023.
//

import Foundation

struct LoginPassw: Encodable {
    var login: String
    var password: String
}

struct OrderResponseStruct: Decodable {
    var status: String
    var date: String
    var total: String
    var note: String
    var destination: String
    var deltime: String
}
