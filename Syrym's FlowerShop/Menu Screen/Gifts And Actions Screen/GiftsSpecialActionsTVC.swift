//
//  GiftsSpecialActionsTVC.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 03.06.2023.
//

import UIKit
import Kingfisher

class GiftsSpecialActionsTVC: UITableViewController {
    
    let giftsClass = GiftsClass()
    
    @IBOutlet var giftsTableView: UITableView!
    
    lazy var refreshCont: UIRefreshControl = {
        let rfc = UIRefreshControl()
        rfc.tintColor = styleColorGreenButton
        rfc.addTarget(self, action: #selector(updateGifts), for: .valueChanged)
        return rfc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateGifts()
        
        giftsTableView.refreshControl = refreshCont
        tableView.backgroundColor = styleColorBackground
        title = "Special Offers"
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return giftsClass.array.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return giftsClass.array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GiftsSpecialActionsTableViewCell
        
        let data = giftsClass.array[indexPath.row]
        
        cell.giftsTitle.text = data.name
        cell.giftsDescription.text = data.description
        
        if let imgURL = URL(string: "\(giftsClass.baseURL)\(data.picture ?? "" )") {
            cell.giftsImage.kf.setImage(with: imgURL)
        }
        
        cell.backgroundColor = .clear
        cell.giftsBackgroundView.backgroundColor = styleColorTableViewCell
        cell.giftsBackgroundView.layer.cornerRadius = styleCornerRadius
        cell.giftsImage.layer.cornerRadius = styleCornerRadius
        cell.giftsTitle.textColor = styleColorGreenButton
        cell.giftsDescription.textColor = .white
        
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
        return cell
    }
    
    // MARK: -- @objc methods
    @objc func updateGifts() {
        if currentReachabilityStatus != .notReachable {
            giftsClass.downloadActionsFromJSON { loaded in
                if loaded {
                    DispatchQueue.main.async {
                        self.giftsTableView.reloadData()
                        self.refreshCont.endRefreshing()
                    }
                } else {
                    AllFunctions.shared.showOnScreenNotif(title: "Unable to download", controller: self)
                }
            }
            
        } else {
            AllFunctions.shared.showOnScreenNotif(title: "No internet connection", controller: self)
        }
    }
}
