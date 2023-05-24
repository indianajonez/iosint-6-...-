//
//  FeedViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    let feedmodel = FeedModel()
    
    let post = Post2(
        title: "Название поста",
        image: UIImage(named: "A316DE42"),
        text: "текст внутри данного поста, очень длинный и важный"
    )
    
    let postTwo = Post2(
        title: "Second Post",
        image: UIImage(named: "A316DE42"),
        text: "Text for second post")
    
    private lazy var textField: UITextField = {
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
            textField.placeholder = "Write the right word here.."
            return textField
        }()
    
    private lazy var buttonOne: CustomButton = {
            let button = CustomButton(title: "Post One", backgroundColor: .brown, navigation: navigationController)
            return button
        }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 20.0
        stack.alignment = .fill
        
        return stack
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "checkGuessButton", backgroundColor: .brown)
        button.addTarget(self, action: #selector(check), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var labelCheck: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .gray
        label.layer.cornerRadius = 5
        return label
    }()
    
    @objc private func check() {
        if self.feedmodel.check(word: textField.text ?? "nothing") {
            self.labelCheck.text = "TRUE"
            self.labelCheck.textColor = .green
            self.labelCheck.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        } else {
            self.labelCheck.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            self.labelCheck.text = "FALSE"
            self.labelCheck.textColor = .red
        }

    }
    
    private lazy var buttonTwo: CustomButton = {
        let button = CustomButton(title: "Post Two", backgroundColor: .brown, navigation: navigationController)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        layout()
    }
    
    private func layout() {
        view.addSubview(stackView)
        view.addSubview(textField)
        view.addSubview(labelCheck)
        view.addSubview(checkGuessButton)
        [buttonOne, buttonTwo].forEach{stackView.addArrangedSubview($0)}
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 200),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 60),
            textField.widthAnchor.constraint(equalToConstant: 300),
            
            checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            checkGuessButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 300),
            
            labelCheck.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 30),
            labelCheck.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                        
        ])
    }

}

