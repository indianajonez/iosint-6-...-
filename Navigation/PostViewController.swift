//
//  PostViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.
//
import UIKit
import StorageService

class PostViewController: UIViewController, Coordinating {
    var coordinator: CoordinatorProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        makeBarItem()
    }
    
    func setupPost(_ post: Post2) {
        self.title = post.title
    }
    
    private func makeBarItem() {
        let buttonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = buttonItem
    }
    @objc private func tapAction(){
        let infoVC = InfoViewController()
        infoVC.coordinator = self.coordinator
        infoVC.title = "Информация о посте"
        coordinator?.present(to: infoVC)
    }


}
