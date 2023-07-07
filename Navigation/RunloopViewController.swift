//
//  RunloopViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 10.06.2023.
//

import UIKit

class RunloopViewController: UIViewController{
    
    
    // MARK: - Public properties
    
    var coordinator: CoordinatorProtocol?
    
    
    // MARK: - Private properties
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var subscribeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Купи подписку и используй все возможности приложения!"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
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
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstrains()
    }
    
    
    // MARK: - Private methods
    
    @objc
    private func buy() {
        print("buy")
        navigationController?.popViewController(animated: true)
    }
    
    private func setupConstrains() {
        view.addSubview(logoImage)
        view.addSubview(subscribeLabel)
        view.addSubview(buyButton)
        
        NSLayoutConstraint.activate([
            
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            buyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 160),
            buyButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            subscribeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            subscribeLabel.widthAnchor.constraint(equalToConstant: 100),
            subscribeLabel.heightAnchor.constraint(equalToConstant: 100),
            subscribeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            subscribeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
}
