//
//  BannerTVC.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 05.06.2023.
//

import UIKit
import Kingfisher

class BannerTVC: UITableViewController {
    
    let bannerClass = BannerClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = styleColorBackground
        
        if currentReachabilityStatus != .notReachable {
            bannerClass.downloadBannerFromJSON { loaded in
                if loaded {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        } else {
            AllFunctions.shared.showOnScreenNotif(title: "No internet connection", controller: self)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BannerTableViewCell else {
            return UITableViewCell()
        }
        
        if let first = bannerClass.array.first {
            cell.titleForBanner.text = first.name
            cell.descriptionForBanner.text = first.description
        }
        
        cell.backgroundColor = .clear
        cell.titleForBanner.textColor = styleColorGreenButton
        cell.descriptionForBanner.textColor = .black
        cell.backGroundViewForBanner.backgroundColor = styleColorTableViewCell

        if indexPath.section == 0 {
            
            guard let cellImage = tableView.dequeueReusableCell(withIdentifier: "cellImage", for: indexPath) as? BannerTableViewCellImage else {
                return UITableViewCell()
            }
            
            if let first = bannerClass.array.first {
                if let imgURL = URL(string: "\(bannerClass.baseURL)\(first.picture ?? "" )") {
                    cellImage.imageForBanner.kf.setImage(with: imgURL)
                }
            }
                        
             cellImage.backgroundColor = .clear
             cellImage.backGroundViewForBanner.backgroundColor = styleColorTableViewCell
             cellImage.backGroundViewForBanner.layer.cornerRadius = styleCornerRadius
             cellImage.imageForBanner.layer.cornerRadius = styleCornerRadius
             cellImage.selectionStyle = .none
            return cellImage
        }
        
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
        return cell
    }
}
