//
//  PhoneNumbersClass.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 15.06.2023.
//

import Foundation

class PhoneNumbersClass {
    var array = [PhoneNumbersStruct]()
    var defaultArray = [PhoneNumbersStruct]()
    
    init() {
        dataSetup()
    }
    
    func dataSetup() {
        array.append(PhoneNumbersStruct(code: 1, country: "USA"))
        array.append(PhoneNumbersStruct(code: 44, country: "UK"))
        array.append(PhoneNumbersStruct(code: 49, country: "Germany"))
        array.append(PhoneNumbersStruct(code: 7, country: "Russia / Kazakhstan"))
        array.append(PhoneNumbersStruct(code: 971, country: "UAE"))
        
        defaultArray = array
    }
}
