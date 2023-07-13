//
//  BannerClass.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 05.06.2023.
//

import Foundation
import UIKit

class BannerClass: NSObject {
    
    var array = [BannerStruct]()
    
    let baseURL = "https://enter3d.ru"
    private let bannerURL = "https://enter3d.ru/json/SyrymShop/banners.php"

    func downloadBannerFromJSON(closure: @escaping ((Bool) -> Void)) {
        
        if currentReachabilityStatus == .notReachable {
            closure(false)
            return
        }
        
        guard let bannerURL = URL(string: bannerURL) else {
            closure(false)
            return
        }
        
        URLSession.shared.dataTask(with: bannerURL) { [self] data, response, err in
            if err == nil {
                if let data {
                    do {
                        array = try
                        
                        JSONDecoder().decode([BannerStruct].self, from: data)

                        DispatchQueue.main.async {
                            closure(true)
                        }
                        
                    } catch {
                        print("Download Banner Error!", error, error.localizedDescription)
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

