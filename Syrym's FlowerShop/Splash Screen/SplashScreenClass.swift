//
//  SplashScreenClass.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 17.06.2023.
//

import Foundation

class SplashScreenClass {
    var array = [SplashStruct]()
    var counter = -1

    init() {
        setupAnimation()
    }
    
    func setupAnimation() {
        array.append(SplashStruct(title: "Syrym's FlowerShop", descr: "Always Fresh", buttonText: "Next", animationName: "1"))
        
        array.append(SplashStruct(title: "Syrym's FlowerShop", descr: "Fast Delivery", buttonText: "Next", animationName: "2"))
        
        array.append(SplashStruct(title: "Syrym's FlowerShop", descr: "Delivery charges on us", buttonText: "OK", animationName: "3"))
    }
        
    func nextAnimation() -> SplashStruct {
        counter += 1
        
        if array.indices.contains(counter) {
            return array[counter]
        } else {
            counter = array.count
            return array[array.count - 1]
        }
    }
}
