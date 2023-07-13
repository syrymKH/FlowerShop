//
//  ClassCategories.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 22.05.2023.
//

import Foundation
import UIKit

class CategoriesClass: NSObject {
    
    var categoryArray = [CategoriesStruct]()
    var categoryArrayDefault = [CategoriesStruct]()

    let baseURL = "https://enter3d.ru"
    private let categoryURL = "https://enter3d.ru/json/SyrymShop/catalog.php"
    
    func downloadCategoryFromJSON(closure: @escaping ((Bool) -> Void)) {
        
        if currentReachabilityStatus == .notReachable {
            closure(false)
            return
        }
        
        guard let categoryURL = URL(string: categoryURL) else {
            closure(false)
            return
        }
        
        URLSession.shared.dataTask(with: categoryURL) { [self] data, response, err in
            if err == nil {
                if let data {
                    do {
                     
                        categoryArray = try
                        
                        JSONDecoder().decode([CategoriesStruct].self, from: data)

                        DispatchQueue.main.async { [self] in
                            categoryArrayDefault = categoryArray
                            closure(true)
                        }
                        
                    } catch {
                        print("Download Category Error!", error, error.localizedDescription)
                        
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
