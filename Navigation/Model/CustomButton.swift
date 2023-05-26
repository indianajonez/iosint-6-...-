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
    

    private var buttonAction: ()->Void
    
    init(title: String , titleColor: UIColor, action: @escaping () -> Void) {
        self.buttonAction = action
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.setBackgroundImage(UIImage(named: "star.circle"), for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.alpha = 1
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(){
        self.buttonAction()
       }
}
    
    
    

