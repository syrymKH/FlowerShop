//
//  SplashScreenVC.swift
//  Syrym's FlowerShop
//
//  Created by Syrym Khamzin on 16.06.2023.
//

import UIKit
import Lottie

class SplashScreenVC: UIViewController {
    
    let copyClass = SplashScreenClass()
    var lottieAnimationView = LottieAnimationView()
    
    var viewForAnimationImage: UIView = {
        let view = UIView()
        view.layer.cornerRadius = styleCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var myStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    var myTitle: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.textColor = styleColorSecondaryLabel
        titleLabel.font = .systemFont(ofSize: 30, weight: .regular)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    var myDescription: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 17, weight: .regular)
        descriptionLabel.textAlignment = .center
        return descriptionLabel
    }()
    
    var myButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = styleCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = styleColorGreenButton
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonAction() {
        loadScreenAnimation(animation: copyClass.nextAnimation())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadScreenAnimation(animation: copyClass.nextAnimation())
    }
    
    func setupUI() {
        view.backgroundColor = styleColorTableViewCell
        
        addComponents()
    }
    
    func addComponents() {
        // MARK: -- stack with 2 labels and constraints
        view.addSubview(myStack)
        myStack.addArrangedSubview(myTitle)
        myStack.addArrangedSubview(myDescription)
        
        NSLayoutConstraint.activate([
            myStack.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 25),
            myStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            myStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // MARK: -- button and constraints
        view.addSubview(myButton)
        NSLayoutConstraint.activate([
            myButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            myButton.heightAnchor.constraint(equalToConstant: 50),
            myButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            myButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // MARK: -- view for animation and constraints
        let maxHeightAndWidth = view.frame.width - 32
        view.addSubview(viewForAnimationImage)
        viewForAnimationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        viewForAnimationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        viewForAnimationImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        viewForAnimationImage.heightAnchor.constraint(equalToConstant: maxHeightAndWidth).isActive = true
    }
    
    func loadScreenAnimation(animation: SplashStruct) {
        myTitle.text = animation.title
        myDescription.text = animation.descr
        myButton.setTitle(animation.buttonText, for: .normal)
        lottieLoadAnimation(animateName: animation.animationName)
        
        if  copyClass.counter == copyClass.array.count {
            closeAnimation()
        }
    }
    
    func lottieLoadAnimation(animateName: String) {
        lottieAnimationView.removeFromSuperview()
        
        lottieAnimationView = .init(name: animateName)
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.frame = CGRect(x: 0, y: 0, width: viewForAnimationImage.frame.width, height: viewForAnimationImage.frame.width)
        lottieAnimationView.layer.cornerRadius = styleCornerRadius
        lottieAnimationView.play()
        viewForAnimationImage.addSubview(lottieAnimationView)
    }
    
    func closeAnimation() {
        dismiss(animated: true)
    }
}
