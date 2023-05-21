//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 19.03.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    
    private lazy var blackView: UIView = {
        let blackView = UIView()
        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.alpha = 0
        blackView.backgroundColor = .black
        blackView.frame = UIScreen.main.bounds
        return blackView
    }()
    
    private lazy var crossButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0.0
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var avatarImage: UIImageView = {
        var image = UIImageView(image: UIImage(named: "HipstaCat"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hipster Cat"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.textColor = .black
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.placeholder = "Write your status..."
        return textField
    }()
    
    
    private lazy var statusLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Waiting for something..."
        label.textColor = .gray
        //label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.backgroundColor = UIColor.blue.cgColor
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(didTaplogInButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTaplogInButton() {
        statusLabel.text = statusTextField.text
        print(statusLabel.text ?? "NOT")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        [avatarImage, fullNameLabel, statusLabel, statusTextField, setStatusButton, ].forEach{addSubview($0)} // добавили аватарку на вью
        layout() // закрепили аватарку на вью
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(user: User?) {
        if let user = user {
            self.fullNameLabel.text = user.fullName
            self.avatarImage.image = user.avatar
        }
    }
    
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(tap)
    }
    
    @objc private func tapAction() {
        addSubview(blackView)
        addSubview(crossButton)
        bringSubviewToFront(avatarImage)
        
        NSLayoutConstraint.activate([
            crossButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            crossButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            crossButton.widthAnchor.constraint(equalToConstant: 30),
            crossButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) { [self] in
            blackView.alpha = 0.85
            avatarImage.layer.cornerRadius = 0
            
            avatarTop.constant = UIScreen.main.bounds.midX
            avatarLeading.constant = 16
            avatarWight.constant = UIScreen.main.bounds.width
            avatarHeight.constant = UIScreen.main.bounds.width
            layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.3) { [self] in
                crossButton.alpha = 1.0
            }
        }
        
    }
    
    @objc private func cancelAction() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [self] in
            crossButton.alpha = 0.0
            crossButton.removeFromSuperview()
        } completion: { _ in
            UIView.animate(withDuration: 0.5) { [self] in
                
                sendSubviewToBack(avatarImage)
                avatarImage.layer.cornerRadius = 50
                avatarTop.constant = 16
                avatarLeading.constant = 16
                avatarWight.constant = 100
                avatarHeight.constant = 100
                blackView.alpha = 0.0
                blackView.removeFromSuperview()
                
                layoutIfNeeded()
            }
        }
    }
    
    private var avatarWight = NSLayoutConstraint()
    private var avatarHeight = NSLayoutConstraint()
    private var avatarTop = NSLayoutConstraint()
    private var avatarLeading = NSLayoutConstraint()
    
    private func layout() {
        
        avatarTop = avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        avatarLeading = avatarImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
        avatarWight = avatarImage.widthAnchor.constraint(equalToConstant: 100)
        avatarHeight = avatarImage.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([
            avatarTop,
            avatarLeading,
            avatarWight,
            avatarHeight,
            
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -240),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fullNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -250),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -270),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 20),
            setStatusButton.heightAnchor.constraint(equalToConstant: 40),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

        ])
    }
}

