//
//  StyleFunctions.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 19.05.2023.
//

import Foundation
import UIKit

func getColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
}

let styleCornerRadius = CGFloat(12)

let styleColorGreenButton = getColor(r: 78, g: 127, b: 105)
let styleColorBackground = getColor(r: 172, g: 200, b: 186)
let styleColorSearchBar = getColor(r: 129, g: 195, b: 171)
let styleColorTableViewCell = UIColor.white
let styleColorSecondaryLabel = UIColor.darkGray
let styleColorTableViewCellDidHighlight = getColor(r: 39, g: 45, b: 31)
let styleErrorColor = getColor(r: 255, g: 126, b: 121)

class AllFunctions {
    static let shared = AllFunctions()
    
    func sendEmail(email: String = "syrym.khamzin@icloud.com", closure: () -> Void?) {
        if let url = URL(string: "mailto:\(email)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                closure()
            }
        }
    }
    
    func callNumber(phone number: String = "+77074930317", closure: () -> Void?) {
        if let phone = URL(string: "tel://\(number)") {
            if UIApplication.shared.canOpenURL(phone) {
                UIApplication.shared.open(phone)
            } else {
                closure()
            }
        }
    }
    
    func showOnScreenNotif(title: String, message: String? = nil, controller: AnyObject) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(cancelButton)
        
        if let vc = (controller as? UIViewController) {
            vc.present(alert, animated: true)
        } else if let tableVC = (controller as? UITableViewController) {
            tableVC.present(alert, animated: true)
        } else if let collectionVC = (controller as? UICollectionViewController) {
            collectionVC.present(alert, animated: true)
        }
    }
}

