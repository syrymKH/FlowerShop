//
//  OrderTVC.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 09.06.2023.
//

import UIKit

class OrderTVC: UITableViewController {
    
    let loadData = UserDefaults.standard
    
    var id: Int?
    var name: String?
    var price: String?
    
    // Country Code from CountryPhoneCodeTVC
    var code: Int?
    
    let postURL = "https://enter3d.ru/json/SyrymShop/orders/order.php"
    
    // MARK: -- Labels
    @IBOutlet weak var priceAndTitleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    
    // MARK: -- TextFields
    @IBOutlet weak var viewForName: UIView!
    @IBOutlet weak var textFieldForName: UITextField!
    
    @IBOutlet weak var viewForPhone: UIView!
    @IBOutlet weak var textFieldForPhone: UITextField!
    
    @IBOutlet weak var viewForAddress: UIView!
    @IBOutlet weak var textFieldForAddress: UITextField!
    
    @IBOutlet weak var viewForNote: UIView!
    @IBOutlet weak var textFieldForNote: UITextField!
    
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var orderButtonOutlet: UIButton!
    
    // MARK: -- Card Payment
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var switchPayment: UISwitch!
    
    // MARK: -- Country Code Button
    @IBOutlet weak var countryCodeOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTextFields()
        setupCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let code = loadData.object(forKey: "code") as? Int {
            print("Code", code)
            countryCodeOutlet.setTitle("+\(code)", for: .normal)
        }
        
        if let order = loadData.object(forKey: "id") as? String {
            deliveryLabel.text = "Your last order ID \(order)"
        }
    }
    
    // MARK: -- IBAction Methods
    @IBAction func paymentSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            paymentLabel.text = "Card Payment"
            switchPayment.thumbTintColor = styleColorGreenButton
        } else {
            paymentLabel.text = "Cash Payment"
            switchPayment.thumbTintColor = .darkGray
        }
    }
    
    @IBAction func orderButtonActionTUI(_ sender: UIButton) {
        sender.backgroundColor = styleColorGreenButton
        orderStatusLabel.isHidden = false
        orderNow()
    }
    
    @IBAction func orderButtonActionTD(_ sender: UIButton) {
        sender.backgroundColor = .darkGray
    }
    
    @IBAction func countryCodeAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DetailScreen", bundle: nil)
        let goToCountryCodeScreen = storyboard.instantiateViewController(identifier: "CountryPhoneCodeTVC")
        navigationController?.pushViewController(goToCountryCodeScreen, animated: true)
    }
    
    // MARK: -- Funcs
    func setupDefaultValues() {
        textFieldForName.text = nil
        textFieldForPhone.text = nil
        textFieldForAddress.text = nil
        textFieldForNote.text = nil
        view.endEditing(true)
    }
    
    func setupUI() {
        title = "Order Details"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        orderStatusLabel.text = nil
        orderStatusLabel.isHidden = true
        
        // MARK: -- Country Code Button
        countryCodeOutlet.layer.cornerRadius = styleCornerRadius
        countryCodeOutlet.layer.masksToBounds = true
        countryCodeOutlet.tintColor = styleColorGreenButton
        countryCodeOutlet.setTitle("+1", for: .normal)
        
        // MARK: -- Switch Button
        switchPayment.thumbTintColor = styleColorGreenButton
        switchPayment.onTintColor = styleColorTableViewCell
        paymentLabel.textColor = .black
        
        // MARK: -- Order Button
        orderButtonOutlet.layer.cornerRadius = styleCornerRadius
        orderButtonOutlet.layer.masksToBounds = true
        orderButtonOutlet.backgroundColor = styleColorGreenButton
        
        view.backgroundColor = styleColorBackground
        priceAndTitleView.backgroundColor = styleColorTableViewCell
        priceAndTitleView.layer.cornerRadius = styleCornerRadius
        titleLabel.textColor = .black
        priceLabel.textColor = styleColorGreenButton
        
        // MARK: -- TextFields
        // 1
        viewForName.backgroundColor = styleColorTableViewCell
        viewForName.layer.cornerRadius = styleCornerRadius
        textFieldForName.borderStyle = .none
        textFieldForName.placeholder = "* Your Name"
        textFieldForName.textColor = .black
        textFieldForName.font = .boldSystemFont(ofSize: 16)
        
        // 2
        viewForPhone.backgroundColor = styleColorTableViewCell
        viewForPhone.layer.cornerRadius = styleCornerRadius
        textFieldForPhone.borderStyle = .none
        textFieldForPhone.placeholder = "* Your Phone Number"
        textFieldForPhone.textColor = .black
        textFieldForPhone.font = .boldSystemFont(ofSize: 16)
        
        // 3
        viewForAddress.backgroundColor = styleColorTableViewCell
        viewForAddress.layer.cornerRadius = styleCornerRadius
        textFieldForAddress.borderStyle = .none
        textFieldForAddress.placeholder = "* Your Address"
        textFieldForAddress.textColor = .black
        textFieldForAddress.font = .boldSystemFont(ofSize: 16)
        
        // 4
        viewForNote.backgroundColor = styleColorTableViewCell
        viewForNote.layer.cornerRadius = styleCornerRadius
        textFieldForNote.borderStyle = .none
        textFieldForNote.placeholder = "Your Note"
        textFieldForNote.textColor = .black
        textFieldForNote.font = .boldSystemFont(ofSize: 16)
    }
    
    func setupTextFields() {
        textFieldForName.delegate = self
        textFieldForPhone.delegate = self
        textFieldForAddress.delegate = self
        textFieldForNote.delegate = self
        
        textFieldForName.clearButtonMode = .whileEditing
        textFieldForPhone.clearButtonMode = .whileEditing
        textFieldForAddress.clearButtonMode = .whileEditing
        textFieldForNote.clearButtonMode = .whileEditing
        
        textFieldForPhone.keyboardType = .numberPad
    }
    
    func setupCell() {
        tableView.separatorStyle = .none
        titleLabel.text = name
        priceLabel.text = "$\(price ?? "")"
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    // MARK: -- Order
    func orderNow() {
        // 1
        if currentReachabilityStatus == .notReachable {
            AllFunctions.shared.showOnScreenNotif(title: "No internet connection", controller: self)
            return
        }
        
        // 2
        let name = textFieldForName.text ?? ""
        let phone = textFieldForPhone.text ?? ""
        let address = textFieldForAddress.text ?? ""
        let note = textFieldForNote.text ?? ""
        
        if name.trimmingCharacters(in: .whitespaces).count < 2 {
            AllFunctions.shared.showOnScreenNotif(title: "Enter valid name", controller: self)
            viewForName.layer.borderWidth = 1
            viewForName.layer.borderColor = styleErrorColor.cgColor
            textFieldForName.becomeFirstResponder()
            setDefaultColor()
            return
        }
        
        if phone.trimmingCharacters(in: .whitespaces).count < 10 {
            AllFunctions.shared.showOnScreenNotif(title: "Enter valid mobile phone number", controller: self)
            viewForPhone.layer.borderWidth = 1
            viewForPhone.layer.borderColor = styleErrorColor.cgColor
            textFieldForPhone.becomeFirstResponder()
            setDefaultColor()
            return
        }
        
        if address.trimmingCharacters(in: .whitespaces).count < 4 {
            AllFunctions.shared.showOnScreenNotif(title: "Enter valid address", controller: self)
            viewForAddress.layer.borderWidth = 1
            viewForAddress.layer.borderColor = styleErrorColor.cgColor
            textFieldForAddress.becomeFirstResponder()
            setDefaultColor()
            return
        }
        
        guard let id = id else {return}
        guard let price = price else {return}
        
        // 3
        let orderData = OrderStruct(id: id, phone: phone, email: "", name: name, address: address, cash: switchPayment.isOn, note: note, sum: price)
        
        // 4
        orderStatusLabel.text = "Sending the order..."
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.deliveryLabel.isHidden = true
        }
        
        // 5
        orderButtonOutlet.alpha = 1
        UIView.animate(withDuration: 1) {
            self.orderButtonOutlet.alpha = 0
        }
        
        // 6
        guard let url = URL(string: postURL) else {return}
        
        // 7
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        // 8
        let encoder = JSONEncoder()
        
        // 9
        do {
            let jsonData = try
            encoder.encode(orderData)
            request.httpBody = jsonData
            
            if let respData = request.httpBody {
                print("Success", String(data: respData, encoding: .utf8) ?? "")
            }
        } catch {
            print("We can not send the data")
            print("Error", error)
            print("Error", error.localizedDescription)
        }
        
        // 10
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            rData, response, error in
            guard let rData = rData else {return}
            
            do {
                let getResponse = try
                JSONDecoder().decode(OrderResponse.self, from: rData)
                print("RESULT", getResponse.result, getResponse.orderid)
                
                DispatchQueue.main.async { [self] in
                    if getResponse.result.lowercased().contains("success") {
                        orderStatusLabel.text = "Order sent. Your order ID \(getResponse.orderid)"
                        loadData.set(getResponse.orderid, forKey: "id")
                        orderStatusLabel.textColor = styleColorGreenButton
                        orderIsDone(orderID: getResponse.orderid)
                        
                        setupDefaultValues()
                    }
                }
            } catch {
                print("Error, we have no response", error)
                print("Error, we have no response", error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    
    func orderIsDone(orderID: String) {
        let alert = UIAlertController(title: "", message: "Check your order status using order ID\nOrder ID: \(orderID)", preferredStyle: .alert)
        
        alert.view.tintColor = styleColorGreenButton
        
        let cancelButton = UIAlertAction(title: "Ok", style: .cancel)
        let startTrackingButton = UIAlertAction(title: "Start Tracking", style: .destructive) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextSB = storyboard.instantiateViewController(identifier: "DeliveryTVC")
            self.navigationController?.pushViewController(nextSB, animated: true)
        }
        
        alert.addAction(startTrackingButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
    
    
    func setDefaultColor() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [self] _ in
            if textFieldForName.text!.count != 0 {
                viewForName.layer.borderColor = styleColorTableViewCell.cgColor
            }
            
            if textFieldForPhone.text?.count != 0 {
                viewForPhone.layer.borderColor = styleColorTableViewCell.cgColor
            }
            
            if textFieldForAddress.text?.count != 0 {
                viewForAddress.layer.borderColor = styleColorTableViewCell.cgColor
            }
        }
    }
}

extension OrderTVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textFieldForName.text?.count ?? 0 >= 2 &&
            textFieldForPhone.text?.isEmpty == true &&
            textFieldForAddress.text?.isEmpty == true
        {textFieldForPhone.becomeFirstResponder()}
        
        else if textFieldForName.text?.count ?? 0 >= 2 &&
                    textFieldForPhone.text?.count ?? 0 >= 9 &&
                    textFieldForAddress.text?.isEmpty == true
        {textFieldForAddress.becomeFirstResponder()}
        
        else if textFieldForName.text?.count ?? 0 >= 2 &&
                    textFieldForPhone.text?.count ?? 0 >= 9 &&
                    textFieldForAddress.text?.count ?? 0 >= 4
        {view.endEditing(true)}
        
        return true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == textFieldForName {
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        if textField == textFieldForPhone {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
}

