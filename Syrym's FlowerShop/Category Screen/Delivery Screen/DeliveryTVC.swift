//
//  DeliveryTVC.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 01.07.2023.
//

import UIKit

class DeliveryTVC: UITableViewController {
    
    var isLogIn = false
    var responseData: OrderResponseStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        loginDialogBox()
    }
    
    func setupSettings() {
        title = "Delivery Status"
        tableView.backgroundColor = styleColorBackground
    }
    
    func loginDialogBox() {
        let alert = UIAlertController(title: "Enter your order number for delivery status", message: nil, preferredStyle: .alert)
        
        alert.view.tintColor = styleColorGreenButton
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let login = UIAlertAction(title: "Get info", style: .destructive) { _ in
            
            guard let ln = alert.textFields?.first else {
                return
            }
            
            self.deliveryStatus(login: ln.text ?? "", password: "1wflx36")
        }
        
        alert.addTextField { ln in
            ln.placeholder = "Order number"
        }
        
        alert.addAction(login)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func deliveryStatus(login: String, password: String) {
        
        let loginAndPassword = LoginPassw(login: login, password: password)
        
        if let url = URL(string: "https://enter3d.ru/json/SyrymShop/delivery/delivery.php") {
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            
            let encoder = JSONEncoder()
            
            do {
                let jsonData = try encoder.encode(loginAndPassword)
                request.httpBody = jsonData
                
            } catch {
                print("ERROR")
            }
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                guard let data = data else { return }
                
                do {
                    let rs = try
                    JSONDecoder().decode(OrderResponseStruct.self, from: data)
                    print("Parse success = ")
                    
                    DispatchQueue.main.async { [self] in
                        print("Good!")
                        print(rs)
                        self.responseData = rs
                        self.isLogIn = true
                        tableView.reloadData()
                    }
                }
                
                catch {
                    DispatchQueue.main.async {
                        //"Error, try again"
                    }
                }
                if error != nil {
                    DispatchQueue.main.async {
                        //"Error"
                    }
                    return
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLogIn == false {
            return 0
        }
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var data = cell.defaultContentConfiguration()
        
        if let responseData {
            
            switch indexPath.row {
            case 0:
                data.text = "Status"
                data.secondaryText = responseData.status
            case 1:
                data.text = "Date"
                data.secondaryText = responseData.date
            case 2:
                data.text = "Total"
                data.secondaryText = responseData.total
            case 3:
                data.text = "Note"
                data.secondaryText = responseData.note
            case 4:
                data.text = "Destination"
                data.secondaryText = responseData.destination
            case 5:
                data.text = "Delivery Time"
                data.secondaryText = responseData.deltime
            default:
                break
            }
        }
        
        // MARK: -- SetupUI
        data.textProperties.color = .white
        data.secondaryTextProperties.color = styleColorSecondaryLabel
        cell.backgroundColor = styleColorBackground
        tableView.backgroundColor = styleColorBackground
        
        cell.contentConfiguration = data
        
        return cell
    }
}
