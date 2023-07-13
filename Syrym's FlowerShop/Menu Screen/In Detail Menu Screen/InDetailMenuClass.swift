//
//  ClassInDetailMenu.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 01.06.2023.
//

import Foundation
import UIKit

class InDetailMenuClass {
    var array = [InDetailMenuSectionStruct]()
    
    func getInformation(rowID: Int) {
        switch rowID {
        case 0:
            setupPaymentArray()
        case 1:
            setupDeliveryArray()
        case 4:
            setupRentalArray()
        case 5:
            setupCompanyArray()
        
        default:
            break
        }
    }
    
    private func setupPaymentArray() {
        array = []
        array.append(InDetailMenuSectionStruct(titleSection: nil, rowsInSection: [InDetailMenuRowsStruct(title: "CARD PAYMENT", subTitle: "Visa, MasterCard, American Express")]))
        
        array.append(InDetailMenuSectionStruct(titleSection: nil, rowsInSection: [InDetailMenuRowsStruct(title: "CASH PAYMENT", subTitle: "Local currency or foreign currency at current exchange rate")]))
    }
    
    private func setupDeliveryArray() {
        array = []
        array.append(InDetailMenuSectionStruct(titleSection: nil, rowsInSection: [InDetailMenuRowsStruct(title: "EXPRESS DELIVERY", subTitle: "Delivery (in 1 hour)")]))
                     
        array.append(InDetailMenuSectionStruct(titleSection: nil, rowsInSection: [InDetailMenuRowsStruct(title: "STANDARD DELIVERY", subTitle: "Delivery (in 3 hours)")]))
    }
    
    private func setupRentalArray() {
        array = []
        array.append(InDetailMenuSectionStruct(titleSection: nil, rowsInSection: [InDetailMenuRowsStruct(title: "RENTAL", subTitle:
            """
            Flowers for rent (for 3 hours)
            
            Flowers for rent (for 6 hours)
            """
        )]))
    }
    
    private func setupCompanyArray() {
        array = []
        array.append(InDetailMenuSectionStruct(titleSection: nil, rowsInSection: [InDetailMenuRowsStruct(title: "ABOUT BUSINESS", subTitle:
            "Flower shop with delivery for any occasion")]))
        
        array.append(InDetailMenuSectionStruct(titleSection: nil, rowsInSection: [InDetailMenuRowsStruct(title: "COVERAGE AREA", subTitle: "All neighborhoods in Almaty")]))
    }
}
