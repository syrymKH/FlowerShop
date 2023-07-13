//
//  ClassMenu.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 27.05.2023.
//

import Foundation
import UIKit

class MenuClass {
    var menuArray = [MenuStruct]()
    
    init() {
        setupSections()
    }
    
    func setupSections() {
        menuArray.append(MenuStruct(
            titleForSection: "Payment and Delivery", section: [
                MenuSectionStruct(id: 0, title: "Payment", subTitle: "Payment options", image: "dollarsign.circle"),
                MenuSectionStruct(id: 1, title: "Delivery", subTitle: "Delivery options", image: "envelope"),
                MenuSectionStruct(id: 2, title: "Work Schedule", subTitle: "Business hours", image: "clock"),
                MenuSectionStruct(id: 3, title: "Deals", subTitle: "Special offers", image: "gift"),
                MenuSectionStruct(id: 4, title: "Rental", subTitle: "Flowers for rent", image: "hourglass")
            ]))
        
        menuArray.append(MenuStruct(titleForSection: "About us", section: [
                MenuSectionStruct(id: 5, title: "About Business", subTitle: "Information about business", image: "house"),
            ]))
        
        menuArray.append(MenuStruct(titleForSection: "Additional", section: [
                MenuSectionStruct(id: 6, title: "Share", subTitle: "Share the app", image: "square.and.arrow.up")
            ]))
    }
    
    func showWorkSchedule(tvc: UITableViewController) {
        let alert = UIAlertController(title: "Business Hours", message:
                       """
                       Tuesday - Sunday:
                       09:00 - 18:00
                       
                       Monday:
                       Closed
                       """,
                                                 preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        
        alert.view.tintColor = styleColorSecondaryLabel
        
        alert.addAction(ok)
        tvc.present(alert, animated: true)
    }
    
    func shareApp(tvc: UITableViewController) {
        let url = "https://github.com/syrymKH?tab=repositories"
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: [])
        tvc.present(activityVC, animated: true)
    }
    
    func tableViewCellForMenu(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MenuTableViewCell else {
                    return UITableViewCell()
                }
                
                let data = menuArray[indexPath.section].section[indexPath.row]
                cell.titleForMenu.text = data.title
                cell.subtitleForMenu.text = data.subTitle
                cell.imageForMenu.image = UIImage(systemName: data.image ?? "")
                
                cell.viewForMenu.backgroundColor = styleColorTableViewCell
                cell.viewForMenu.layer.cornerRadius = styleCornerRadius
                cell.imageForMenu.layer.cornerRadius = styleCornerRadius
                cell.imageForMenu.tintColor = styleColorGreenButton
                cell.subtitleForMenu.textColor = styleColorSecondaryLabel
                
                return cell
    }
    
    func goToActionsScreen(navCont: UINavigationController?) {
        let myStoryboard = UIStoryboard(name: "GiftsAndActions", bundle: nil)
        let openScreen = myStoryboard.instantiateViewController(identifier: "GiftsSpecialActionsTVC")
        navCont?.pushViewController(openScreen, animated: true)
    }
    
    func goToPaymentDeliveryCompanyAndMore(tvc: UITableViewController, id: Int) {
        let storyboard = UIStoryboard(name: "MenuTableVC", bundle: nil)
        guard let goToTV = storyboard.instantiateViewController(identifier: "InDetailMenuTableViewCell") as? InDetailMenuTVC else { return }
                goToTV.idFromMenu = id
                tvc.present(goToTV, animated: true)
    }
}
