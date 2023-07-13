//
//  CountryPhoneCodeTVC.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 14.06.2023.
//

import UIKit

class CountryPhoneCodeTVC: UITableViewController {
    
    @IBOutlet weak var backGroundViewForHeader: UIView!
    @IBOutlet weak var searchBarForSearch: UISearchBar!
    @IBOutlet weak var headerCodeLabel: UILabel!
    @IBOutlet weak var headerCountryLabel: UILabel!
    
    let copyClass = PhoneNumbersClass()
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarSetup()
        setupUI()
    }
    
    // MARK: -- Methods
    func setupUI() {
        view.backgroundColor = styleColorBackground
        tableView.backgroundColor = styleColorBackground
        backGroundViewForHeader.backgroundColor = styleColorBackground
        searchBarForSearch.backgroundColor = styleColorSearchBar
        headerCodeLabel.textColor = .darkGray
        headerCountryLabel.textColor = .darkGray
        title = "Country Code"
    }
    
    // MARK: -- searchBar Settings
    func searchBarSetup() {
        
        searchBarForSearch.searchTextField.delegate = self
        searchBarForSearch.delegate = self
        
        searchBarForSearch.barTintColor = styleColorSearchBar
        searchBarForSearch.searchTextField.backgroundColor = styleColorSearchBar
        searchBarForSearch.layer.cornerRadius = styleCornerRadius
        searchBarForSearch.layer.masksToBounds = true
        searchBarForSearch.searchTextField.textColor = .white
        searchBarForSearch.tintColor = .white
        searchBarForSearch.placeholder = "Search"
    }
    
    // MARK: -- Filter for SearchBar Setup
    func filterSearchItem(text: String) {
        copyClass.array = copyClass.defaultArray.filter({ element in
            return element.country.lowercased().contains(text.lowercased())
        })
        
        tableView.reloadData()
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBarForSearch.endEditing(true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        copyClass.array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryPhoneCodeTVCell else {
            return UITableViewCell()
        }
        
        let data = copyClass.array[indexPath.row]
        
        cell.backgroundColor = styleColorTableViewCell
        cell.codeLabel.text = "+\(data.code)"
        cell.countryLabel.text = data.country
        cell.codeLabel.textColor = styleColorGreenButton
        cell.countryLabel.textColor = .black
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = copyClass.array[indexPath.row]
        saveData.set(data.code, forKey: "code")
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Country Code"
    }
}
extension CountryPhoneCodeTVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

extension CountryPhoneCodeTVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            let text = searchText.lowercased().trimmingCharacters(in: .whitespaces)
            filterSearchItem(text: text)
        } else {
            copyClass.array = copyClass.defaultArray
            searchBar.searchTextField.backgroundColor = styleColorSearchBar
            tableView.reloadData()
        }
        
        if searchText.isEmpty == false && copyClass.array.isEmpty == false {
            searchBar.searchTextField.backgroundColor = styleColorSearchBar
        } else if searchText.isEmpty == false && copyClass.array.isEmpty {
            searchBar.searchTextField.backgroundColor = .red
        } else if searchText.isEmpty && copyClass.array.isEmpty == false {
            searchBar.searchTextField.backgroundColor = styleColorSearchBar
        } else if searchText.isEmpty && copyClass.array.isEmpty {
            searchBar.searchTextField.backgroundColor = styleColorSearchBar }
    }
}
