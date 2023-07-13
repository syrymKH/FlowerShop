//
//  InDetailMenuTableViewCell.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 01.06.2023.
//

import UIKit

class InDetailMenuTVC: UITableViewController {
    
    var idFromMenu: Int?
    
    let classCopy = InDetailMenuClass()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = styleColorBackground
        
        if let idFromMenu {
            classCopy.getInformation(rowID: idFromMenu)
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return classCopy.array.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classCopy.array[section].rowsInSection.count
    }

    // MARK: -- CELL
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let data = classCopy.array[indexPath.section].rowsInSection[indexPath.row]
        
        var customCell = cell.defaultContentConfiguration()
        
        customCell.text = data.title
        customCell.textProperties.color = .white
        customCell.secondaryText = data.subTitle
        customCell.secondaryTextProperties.color = styleColorSecondaryLabel
        customCell.image = UIImage(systemName: data.image ?? "")
        customCell.imageProperties.tintColor = styleColorGreenButton
        
        cell.contentConfiguration = customCell
        
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
        cell.backgroundColor = styleColorTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        classCopy.array[section].titleSection
    }
}
