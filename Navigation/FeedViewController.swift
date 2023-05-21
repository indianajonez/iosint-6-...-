//
//  FeedViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.
//

import UIKit
import Foundation
import StorageService

class FeedViewController: UIViewController {

    let post = Post2(
        title: "Название поста",
        image: UIImage(named: "A316DE42"),
        text: "текст внутри данного поста, очень длинный и важный"
    )
    
    let postTwo = Post2(
        title: "Second Post",
        image: UIImage(named: "A316DE42"),
        text: "Text for second post")
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally // fillProportionally
        stack.spacing = 20.0
        stack.alignment = .fill
        
        return stack
    }()
    
    private lazy var buttonOne: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("Post One", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButtonViewPost), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonTwo: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("Post Two", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButtonViewPostTwo), for: .touchUpInside)
        return button
    }()
    
    @objc private func tapButtonViewPost(){
        let postVC = PostViewController()
        postVC.navigationItem.title = post.title
        navigationController?.pushViewController(postVC, animated: true)
    }
    @objc private func tapButtonViewPostTwo(){
        let postVC = PostViewController()
        postVC.navigationItem.title = postTwo.title
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        layout()
    }
    
    private func layout() {
        view.addSubview(stackView)
        [buttonOne, buttonTwo].forEach{stackView.addArrangedSubview($0)}
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

