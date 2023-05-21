//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow //назначаем цвет фона в модальном открытии кнопки меню Инфо
        makeButton()
    }
    
    func makeButton() { //черная кнопка по центру модального экрана
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.center = view.center
        button.setTitle("Закрыть", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func tapAction(){
        let alert = UIAlertController(title: "Перейти назад", message: "что ты хочешь сделать?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Выйти", style: .default) { _ in
            print("Выход из окна информация")
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive) { _ in
            print("отмена выхода из просмотра информации")
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
