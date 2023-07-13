//
//  GiftsClass.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 05.06.2023.
//

import Foundation
import UIKit

class GiftsClass: NSObject {
 
    var array = [GiftsStruct]()
    var arrayDefault = [GiftsStruct]()
    
    let baseURL = "https://enter3d.ru"
    private let giftsURL = "https://enter3d.ru/json/SyrymShop/actions.php"

    func downloadActionsFromJSON(closure: @escaping ((Bool) -> Void)) {
        
        if currentReachabilityStatus == .notReachable {
            closure(false)
            return
        }
        
        guard let giftsURL = URL(string: giftsURL) else {
            closure(false)
            return
        }
        
        URLSession.shared.dataTask(with: giftsURL) { [self] data, response, err in
            if err == nil {
                if let data {
                    do {
                        array = try
                        
                        JSONDecoder().decode([GiftsStruct].self, from: data)
                        
                        DispatchQueue.main.async { [self] in
                            arrayDefault = array
                            closure(true)
                        }
                        
                    } catch {
                        print("Download Gifts Error!", error, error.localizedDescription)
                        closure(false)
                    }
                    
                } else {
                    closure(false)
                }
                
            } else {
                closure(false)
            }
        }.resume()
    }
}

