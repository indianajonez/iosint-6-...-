//
//  RunloopViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 10.06.2023.
//

import UIKit

class RunloopViewController: UIViewController, Coordinating {
    var coordinator: CoordinatorProtocol?
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var SubscribeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Купи подписку и используй все возможности приложения"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(rgb: 0x4885CC)
        button.layer.cornerRadius = 10
        button.setTitle("Buy", for: .normal)
        button.addTarget(self, action: #selector(buy), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //layout()
    }
    
    @objc private func buy() {
        print("buy")
        navigationController?.popViewController(animated: true)
    }
    
    private func layout() {
        view.addSubview(logoImage)
        view.addSubview(SubscribeLabel)
        view.addSubview(buyButton)
        
        NSLayoutConstraint.activate([
            
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            buyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 200),
            buyButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            buyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            
            SubscribeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            SubscribeLabel.widthAnchor.constraint(equalToConstant: 100),
            SubscribeLabel.heightAnchor.constraint(equalToConstant: 100),
            SubscribeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            
            
        ])
    }
    
}
