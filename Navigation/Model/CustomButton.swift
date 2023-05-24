//
//  CustomButton.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 22.05.2023.
//

import UIKit

// Создайте собственный класс кнопки CustomButton как дочерний класс UIButton, где:
//будет собственный инициализатор, в который передаются, к примеру, параметры title, titleColor и другие по необходимости;
//замыкание, в котором вызывающий объект, контроллер или родительский UIView, определят действие по нажатию кнопки;
//реализацию @objc private func buttonTapped() логично спрятать внутрь класса CustomButton.
//Замените для всех экранов стандартные UIButton на вашу собственную CustomButton там, где это целесообразно. Обратите внимание, насколько ваш исходный код стал компактнее и яснее.

class CustomButton: UIButton {
    
    private var title: String?
    private var navigationController: UINavigationController?
    
    convenience init(title:String? = "Title", titleColor: UIColor? = .black, backgroundColor: UIColor? = .black, navigation: UINavigationController? = UINavigationController()) {
        self.init()
        self.title = title
        self.navigationController = navigation
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(){
        let postVC = PostViewController()
        postVC.navigationItem.title = self.title
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}




