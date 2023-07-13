//
//  GoodsFromCategoriesCollectionControllerView.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 29.05.2023.
//

import UIKit
import Kingfisher

class GoodsFromCategoriesCollectionControllerView: UIViewController {
    
    var idFromCategory: Int?
    var categoryTitle: String?
    
    let goodsClass = GoodsClass()
    
    @IBOutlet weak var goodsCollectionView: UICollectionView!
    
    lazy var refreshControl: UIRefreshControl = {
        
        let rfc = UIRefreshControl()
        rfc.tintColor = styleColorGreenButton
        rfc.addTarget(self, action: #selector(updateGoods), for: .valueChanged)
        return rfc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateGoods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = categoryTitle
    }
    
    func setupUI() {
        goodsCollectionView.delegate = self
        goodsCollectionView.dataSource = self
        
        goodsCollectionView.refreshControl = refreshControl
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        view.backgroundColor = styleColorBackground
        goodsCollectionView.backgroundColor = styleColorBackground
        
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"), style: .done, target: self, action: #selector(filterFunction))
        filterButton.tintColor = styleColorGreenButton
        navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc func filterFunction() {
        let alert = UIAlertController(title: "Alert", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let sortMinToMax = UIAlertAction(title: "Sort Min > Max", style: .destructive) { [self] _ in
            goodsClass.array.sort(by: {$0.price < $1.price})
            goodsCollectionView.reloadData()
        }
        
        let sortMaxToMin = UIAlertAction(title: "Sort Max > Min", style: .destructive) { [self] _ in
            goodsClass.array.sort(by: {$0.price > $1.price})
            goodsCollectionView.reloadData()
        }
        
        alert.view.tintColor = styleColorSecondaryLabel
        
        alert.addAction(sortMinToMax)
        alert.addAction(sortMaxToMin)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
 @objc func updateGoods() {
        
     guard let idFromCategory = idFromCategory else {
         title = "Error! Goods not found"
         return
     }
     
      guard currentReachabilityStatus != .notReachable else {
        title = "No internet connection"
        return
    }
        
     goodsClass.downloadGoodsFromJSON(id: idFromCategory) { loaded in
         if loaded {
             DispatchQueue.main.async { [self] in
                 goodsCollectionView.reloadData()
                 refreshControl.endRefreshing()
             }
         }
     }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        goodsCollectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if goodsCollectionView.contentOffset.y <= 0 {
                
                navigationController?.setNavigationBarHidden(false, animated: true)
            } else if goodsCollectionView.contentOffset.y > 50 {
                navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailScreen", bundle: nil)
        if let goToStoryboard = storyboard.instantiateViewController(identifier: "DetailScreenTVC") as? DetailScreenTVC {
           
            let data = goodsClass.array[indexPath.row]
            
            goToStoryboard.id = data.id
            goToStoryboard.name = data.name
            goToStoryboard.price = data.price
            goToStoryboard.descr = data.description
            goToStoryboard.picture = data.picture
            
            title = ""
            navigationController?.pushViewController(goToStoryboard, animated: true)
        }
    }
}

extension GoodsFromCategoriesCollectionControllerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        goodsClass.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = goodsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GoodsFromCategoriesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = goodsClass.array[indexPath.row]
        
        cell.imageConstraint.constant = cell.frame.width
        cell.imageGoods.layer.cornerRadius = styleCornerRadius
        
        cell.titleGoods.font = .boldSystemFont(ofSize: 17)
        cell.titleGoods.textColor = .black
        cell.titleGoods.numberOfLines = 2
        
        cell.priceGoods.textColor = styleColorGreenButton
        
        cell.backgroundColor = styleColorTableViewCell
        cell.layer.cornerRadius = styleCornerRadius
        
        cell.titleGoods.text = data.name
        cell.priceGoods.text = "$\(data.price)"
        
        if let imgURL = URL(string: "\(goodsClass.baseURL)\(data.picture ?? "")") {
            cell.imageGoods.kf.setImage(with: imgURL)
        }
        
        return cell
    }
    
    // MARK: -- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxWidth = (collectionView.frame.width / 2) - 10
        let maxHeight = maxWidth + 80
        return CGSize(width: maxWidth, height: maxHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        // cell height calculation and calculation of components within the cell
        // CellW = 100
        // CellH = 250 - image width - 50
        // Image WH 100
        // cW + 10 + 5 + 5 + 21 + 21 + 5
    }
}
