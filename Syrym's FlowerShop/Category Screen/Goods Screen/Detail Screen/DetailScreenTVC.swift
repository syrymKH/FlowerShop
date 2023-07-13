//
//  DetailScreenTVC.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 06.06.2023.
//

import UIKit
import Kingfisher

class DetailScreenTVC: UIViewController {
    
    let baseURL = "https://enter3d.ru"
    
    var id: Int?
    var name: String?
    var price: String?
    var picture: String?
    var descr: String?
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var orderButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = styleColorBackground
        tableViewOutlet.backgroundColor = styleColorBackground
        
        title = "About Product"
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up.circle"), style: .plain, target: self, action: #selector(shareOptions))
        navigationItem.rightBarButtonItem = shareButton
        
        orderButtonSetup()
    }
    
    func orderButtonSetup() {
        orderButtonOutlet.layer.cornerRadius = styleCornerRadius
        orderButtonOutlet.backgroundColor = styleColorGreenButton
        orderButtonOutlet.tintColor = .white
    }
    
    @IBAction func orderButtonTUI(_ sender: UIButton) {
        sender.backgroundColor = styleColorGreenButton
        let storyboard = UIStoryboard(name: "DetailScreen", bundle: nil)
        if let goToNextScreen = storyboard.instantiateViewController(identifier: "OrderTVC") as? OrderTVC {
            
            goToNextScreen.id = id
            goToNextScreen.name = name
            goToNextScreen.price = price
            
            navigationController?.pushViewController(goToNextScreen, animated: true)
        }
    }
    
    @IBAction func orderButtonTD(_ sender: UIButton) {
        sender.backgroundColor = .darkGray
    }
}

extension DetailScreenTVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageCell = tableViewOutlet.dequeueReusableCell(withIdentifier: "cellImage", for: indexPath) as! DetailScreenImageCell
        
        let titlePriceCell = tableViewOutlet.dequeueReusableCell(withIdentifier: "cellTitlePrice", for: indexPath) as! DetailScreenTitlePriceCell
        
        let descriptionCell = tableViewOutlet.dequeueReusableCell(withIdentifier: "cellDescription", for: indexPath) as! DetailScreenDescriptionCell
        
        tableViewOutlet.separatorStyle = .none
        
        if indexPath.row == 0 {
            if let picture {
                if let img = URL(string: "\(baseURL)\(picture)") {
                    imageCell.pictureForImageCell.kf.setImage(with: img)
                }
            }
            
            imageCell.backGroundViewForImage.layer.cornerRadius = styleCornerRadius
            imageCell.pictureForImageCell.layer.cornerRadius = styleCornerRadius
            imageCell.pictureForImageCell.contentMode = .scaleAspectFill
            imageCell.backgroundColor = .clear
            imageCell.selectionStyle = .none
            
            if picture != nil {
                imageCell.pictureForImageCell.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(imageFullScreen)))
            }
            
            return imageCell
        }
        
        if indexPath.row == 1 {
            
            if let name, let price {
                titlePriceCell.titleLabel.text = name
                titlePriceCell.priceLabel.text = "$\(price)"
                titlePriceCell.priceLabel.textColor = styleColorGreenButton
            }
            
            titlePriceCell.backGroundView.layer.cornerRadius = styleCornerRadius
            titlePriceCell.backGroundView.backgroundColor = styleColorTableViewCell
            titlePriceCell.titleLabel.textColor = .black
            titlePriceCell.backgroundColor = .clear
            titlePriceCell.selectionStyle = .none
            
            return titlePriceCell
        }
        
        if indexPath.row == 2 {
            
            if let descr {
                descriptionCell.descriptionLabel.text = descr
            }
            
            descriptionCell.backGroundView.layer.cornerRadius = styleCornerRadius
            descriptionCell.backGroundView.backgroundColor = styleColorTableViewCell
            descriptionCell.descriptionLabel.textColor = .black
            descriptionCell.backgroundColor = .clear
            descriptionCell.selectionStyle = .none
            
            return descriptionCell
        }
        
        return imageCell
    }
    
    // MARK: -- objc Methods
    @objc func imageFullScreen() {
        let fullScreenImage = FullScreenImage()
        fullScreenImage.urlImage = picture
        present(fullScreenImage, animated: true)
    }
    
    @objc func shareOptions() {
        let alert = UIAlertController(title: "Share", message: nil, preferredStyle: .alert)
        let pictureIMG = UIAlertAction(title: "Picture", style: .destructive) { [self] _ in
            
            guard let picture = picture else {return}
            guard let img = URL(string: "\(baseURL)\(picture)") else {return}
            let setImageForShare = UIImageView()
            setImageForShare.kf.setImage(with: img)
                  
            if let checkImage = setImageForShare.image {
                let sharePicture = UIActivityViewController(activityItems: [checkImage], applicationActivities: [])
                present(sharePicture, animated: true)
            }
        }
        
        let text = UIAlertAction(title: "Text", style: .destructive) { [self] _ in
            let text = "\(name ?? "")\(price ?? "")\(descr ?? "")"
            let shareText = UIActivityViewController(activityItems: [text], applicationActivities: [])
            present(shareText, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.view.tintColor = styleColorSecondaryLabel
        
        alert.addAction(pictureIMG)
        alert.addAction(text)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
