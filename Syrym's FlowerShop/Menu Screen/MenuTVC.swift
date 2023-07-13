//
//  MenuTableVC.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 27.05.2023.
//

import UIKit

class MenuTVC: UITableViewController {
    
    let menuClass = MenuClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = styleColorBackground
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        menuClass.menuArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuClass.menuArray[section].section.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        menuClass.tableViewCellForMenu(tableView: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowIndex = menuClass.menuArray[indexPath.section].section[indexPath.row].id
        
        switch rowIndex {
        case 0, 1, 4, 5:
            menuClass.goToPaymentDeliveryCompanyAndMore(tvc: self, id: rowIndex)
        case 2:
            menuClass.showWorkSchedule(tvc: self)
        case 3:
            menuClass.goToActionsScreen(navCont: navigationController)
        case 6:
            menuClass.shareApp(tvc: self)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuTableViewCell else {return}
        cell.viewForMenu.backgroundColor = styleColorTableViewCellDidHighlight
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuTableViewCell else {return}
        cell.viewForMenu.backgroundColor = styleColorTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        menuClass.menuArray[section].titleForSection
    }
}
