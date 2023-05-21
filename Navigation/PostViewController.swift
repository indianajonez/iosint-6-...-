//
//  PostViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.
//
//
//  PostViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.
//
import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        makeBarItem()
    }
    
    private func makeBarItem() {
        let buttonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = buttonItem
    }
    @objc private func tapAction(){
        let infoVC = InfoViewController()
        infoVC.title = "Информация о посте"
        present(infoVC, animated: true)
    }


}
