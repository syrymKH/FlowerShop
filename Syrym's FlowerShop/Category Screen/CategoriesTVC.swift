//
//  ViewController.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 19.05.2023.
//

import UIKit
import Kingfisher

class CategoriesTVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    let savedData = UserDefaults.standard
    
    let categories = CategoriesClass()
    let banner = BannerClass()
    
    lazy var refreshControl: UIRefreshControl = {
        
        let rfc = UIRefreshControl()
        rfc.tintColor = styleColorGreenButton
        rfc.addTarget(self, action: #selector(updateCategories), for: .valueChanged)
        return rfc
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateCategories()
        searchBarSetup()
        checkSplashScreenStatus()
    }
    
    @IBAction func firstLineTapGesture(_ sender: UITapGestureRecognizer) {
        showBannerScreen()
    }
    
    @IBAction func secondLineTapGesture(_ sender: UITapGestureRecognizer) {
        showBannerScreen()
    }
    
    // MARK: -- Methods
    func showBannerScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let goToNextVC = storyboard.instantiateViewController(identifier: "BannerTVC")
        present(goToNextVC, animated: true)
    }
    
    func checkSplashScreenStatus() {
        let splashScreenStatus = savedData.bool(forKey: "splash")
        if splashScreenStatus == true {
            openSplashScreen()
        }
    }
    
    func openSplashScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let openSplashScreen = storyboard.instantiateViewController(identifier: "SplashScreenVC")
        
        openSplashScreen.modalPresentationStyle = .fullScreen
        savedData.set(false, forKey: "splash")
        present(openSplashScreen, animated: false)
    }
    
    func setupUI() {
        categoryTableView.refreshControl = refreshControl
        
        view.backgroundColor = styleColorBackground
        categoryTableView.backgroundColor = styleColorBackground
        
        let titleLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 50, height: 30))
        titleLbl.text = "Syrym's FlowerShop"
        titleLbl.textColor = .black
        tabBarController?.navigationItem.titleView = titleLbl
    
        let contactUsButton = UIBarButtonItem(image: UIImage(systemName: "phone.circle"), style: .done, target: self, action: #selector(contactUS))
        contactUsButton.tintColor = styleColorGreenButton
        
        let splashScreenButton = UIBarButtonItem(image: UIImage(systemName: "questionmark.circle"), style: .done, target: self, action: #selector(showSplashScreen))
        
        let orderStatus = UIBarButtonItem(image: UIImage(systemName: "box.truck.fill"), style: .done, target: self, action: #selector(showOrderStatus))
        
        tabBarController?.navigationItem.rightBarButtonItems = [contactUsButton, splashScreenButton, orderStatus]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if categoryTableView.contentOffset.y <= 0 {

            navigationController?.setNavigationBarHidden(false, animated: true)
        } else if categoryTableView.contentOffset.y > 50 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func searchBarSetup() {
        // MARK: -- SearchBar
        searchBar.searchTextField.delegate = self
        searchBar.delegate = self
        
        searchBar.barTintColor = styleColorSearchBar
        searchBar.searchTextField.backgroundColor = styleColorSearchBar
        searchBar.layer.cornerRadius = styleCornerRadius
        searchBar.layer.masksToBounds = true
        searchBar.searchTextField.textColor = .black
        searchBar.tintColor = .black
        searchBar.placeholder = "Search"
    }
    
    func filterSearchItem(text: String) {
        categories.categoryArray = categories.categoryArrayDefault.filter({ element in
            return element.name.lowercased().contains(text.lowercased())
        })
        
        categoryTableView.reloadData()
    }
    
    // MARK: -- @objc Methods
    @objc func contactUS() {
        let alert = UIAlertController(title: "MENU", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let call = UIAlertAction(title: "Call", style: .destructive) { _ in
            AllFunctions.shared.callNumber {}
        }
        let email = UIAlertAction(title: "Email", style: .destructive) { _ in
            AllFunctions.shared.sendEmail {}
        }
        
        alert.view.tintColor = styleColorSecondaryLabel
        
        alert.addAction(call)
        alert.addAction(email)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc func showSplashScreen() {
        savedData.set(true, forKey: "splash")
        checkSplashScreenStatus()
    }
    
    @objc func showOrderStatus() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextSB = storyboard.instantiateViewController(identifier: "DeliveryTVC")
        navigationController?.pushViewController(nextSB, animated: true)
    }
    
    func updateBanner() {
        if currentReachabilityStatus != .notReachable {
            
            banner.downloadBannerFromJSON { loaded in
                if loaded {
                    DispatchQueue.main.async { [self] in
                        guard let first = banner.array.first else { return }
                        mainLabel.text = first.name
                    }
                }
            }
        }
    }
    
    @objc func updateCategories() {
        if currentReachabilityStatus != .notReachable {
            
            updateBanner()
            
            categories.downloadCategoryFromJSON { loaded in
                if loaded {
                    DispatchQueue.main.async {
                        self.categoryTableView.reloadData()
                        self.refreshControl.endRefreshing()
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

// MARK: -- TableViewDelegate & TableViewDataSource
extension CategoriesTVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = categoryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CategoriesTableViewCell else {
            return UITableViewCell()
        }
        
        let data = categories.categoryArray[indexPath.row]
        let stringImageURL = "\(categories.baseURL)\(data.picture ?? "")"
        if let imgURL = URL(string: stringImageURL) {
            cell.categoryImage.kf.setImage(with: imgURL)
        }
        
        cell.categoryBackgroundView.backgroundColor = styleColorTableViewCell
        cell.categoryPrimaryTitle.text = data.name
        cell.categoryBackgroundView.layer.cornerRadius = styleCornerRadius
        cell.categoryImage.layer.cornerRadius = styleCornerRadius
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
        
        // size calculation
        // 84 x 84
        // 84 + 16 = 100 + 10?
        // 130 - 7 - 7 = 130 - 14 = 116
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = categories.categoryArray[indexPath.row]

        let newStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let gotoNewStoryboard = newStoryboard.instantiateViewController(identifier: "GoodsFromCategoriesCollectionControllerView") as? GoodsFromCategoriesCollectionControllerView {
            gotoNewStoryboard.idFromCategory = data.id
            gotoNewStoryboard.categoryTitle = data.name
            navigationController?.pushViewController(gotoNewStoryboard, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = categoryTableView.cellForRow(at: indexPath) as? CategoriesTableViewCell {
            cell.categoryBackgroundView.backgroundColor = styleColorTableViewCellDidHighlight
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = categoryTableView.cellForRow(at: indexPath) as? CategoriesTableViewCell {
            cell.categoryBackgroundView.backgroundColor = styleColorTableViewCell
        }
    }
}
// MARK: -- TextFieldDelegate
extension CategoriesTVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

// MARK: -- SearchBarDelegate
extension CategoriesTVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            let text = searchText.lowercased().trimmingCharacters(in: .whitespaces)
            filterSearchItem(text: text)
        } else {
            categories.categoryArray = categories.categoryArrayDefault
            searchBar.searchTextField.backgroundColor = styleColorSearchBar
            categoryTableView.reloadData()
        }
        
        if searchText.isEmpty == false && categories.categoryArray.isEmpty == false {
            searchBar.searchTextField.backgroundColor = styleColorSearchBar
        } else if searchText.isEmpty == false && categories.categoryArray.isEmpty {
            searchBar.searchTextField.backgroundColor = .red
        } else if searchText.isEmpty && categories.categoryArray.isEmpty == false {
            searchBar.searchTextField.backgroundColor = styleColorSearchBar
        } else if searchText.isEmpty && categories.categoryArray.isEmpty {
            searchBar.searchTextField.backgroundColor = styleColorSearchBar }
    }
}
