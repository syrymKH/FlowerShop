//
//  ClassGoods.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 02.06.2023.
//

import Foundation

class GoodsClass: NSObject {
    var array = [GoodsStruct]()
    var defaultArray = [GoodsStruct]()
    
    let baseURL = "https://enter3d.ru"
    let goodsURL = "https://enter3d.ru/json/SyrymShop/section.php?id="
    
    func downloadGoodsFromJSON(id: Int, closure: @escaping ((Bool) -> Void)) {
        
        if currentReachabilityStatus == .notReachable {
            closure(false)
            return
        }
        
        guard let goodsURL = URL(string: "\(goodsURL)\(id)") else {
            closure(false)
            return
        }
        
        URLSession.shared.dataTask(with: goodsURL) { [self] data, response, err in
            if err == nil {
                if let data {
                    do {
                        array = try
                        
                        JSONDecoder().decode([GoodsStruct].self, from: data)
                        
                        DispatchQueue.main.async { [self] in
                            defaultArray = array
                            closure(true)
                        }
                        
                    } catch {
                        print("Download Goods Error!", error, error.localizedDescription)
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

