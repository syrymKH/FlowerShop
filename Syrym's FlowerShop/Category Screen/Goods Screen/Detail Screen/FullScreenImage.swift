//
//  FullScreenImage.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 09.06.2023.
//

import UIKit
import Kingfisher

class FullScreenImage: UIViewController {
    
    var urlImage: String?
    let baseURL = "https://enter3d.ru"

    let picture: UIImageView = {
        let picture = UIImageView()
        picture.translatesAutoresizingMaskIntoConstraints = false
        return picture
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = styleColorBackground
        view.addSubview(picture)
        picture.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        picture.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        picture.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        picture.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        picture.contentMode = .scaleAspectFit
        
        if let img = URL(string: "\(baseURL)\(urlImage ?? "")") {
            picture.kf.setImage(with: img)
        }
    }
}
