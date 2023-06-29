//
//  PostViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.
//
import UIKit
import StorageService

class PostViewController: UIViewController {
    
    
    // MARK: - Public properties
    
    var coordinator: CoordinatorProtocol?

    
    // MARK: - Lifecycles / Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        makeBarItem()
    }
    
    
    // MARK: - Public methods
    
    func setupPost(_ post: Post2) {
        self.title = post.title
    }
    
    // MARK: - Private methods
    
    private func makeBarItem() {
        let buttonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    @objc
    private func tapAction(){
        let infoVC = InfoViewController()
        infoVC.coordinator = self.coordinator
        infoVC.title = "Информация о посте"

    }
}

