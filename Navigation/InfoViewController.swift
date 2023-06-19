//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.

import UIKit

class InfoViewController: UIViewController{
    
    // MARK: - Public properties
    
    var coordinator: CoordinatorProtocol?
    
    let cancelAction = UIAlertAction(title: "Отмена", style: .destructive) { _ in
        print("отмена выхода из просмотра информации")
    }
    
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        makeButton()
    }
    
    
    // MARK: - Public methods
    
    func makeButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.center = view.center
        button.setTitle("Закрыть", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    // MARK: - Private methods
    
    @objc
    private func tapAction(){
        let alert = UIAlertController(
            title: "Перейти назад",
            message: "что ты хочешь сделать?",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "Выйти",
            style: .default
        ){
            _ in
            print("Выход из окна информация")
            self.popoverPresentationController
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
