//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    enum ValidationError: Error { //для проверки логина и пароля через аллерт
            case notFound
        }
    
    var currentUser: User? // В существующий класс ProfileViewController добавьте свойство типа User и сделайте отображение этой информации на экране профиля, включая изображение аватара.
    private var listPost = Post2.make()
    private var listPhoto = Photo.makeCollectionPhotos()

    
    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain) //поменять стиль
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .lightGray
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier) //регистрация ячейки c фото для переиспользования
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier) //регистрация ячейки c постами для переиспользования
        return table
    }()
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        #if DEBUG
        view.backgroundColor = .cyan
        #else
        view.backgroundColor = .lightGray
        #endif
        // Смоделируем случай, когда в схеме Debug, которая была создана по результатам первой домашней работы, вводится тестовый логин.

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layout()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func layout() {
        
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    } // auto math height size for cell
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileHeaderView()
        header.setView(user: currentUser)
         // В существующий класс ProfileViewController добавьте свойство типа User и сделайте отображение этой информации на экране профиля, включая изображение аватара.
        header.backgroundColor = .lightGray
        return section == 0 ? header : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return section == 0 ? 220 : 0
        }
}

// MARK: - UITableViewDataSource дата сорс отвечает за то, чтобы наполнить таблицу данными

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : listPost.count // с помощью этого метода указываем кол-во ячеек
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // здесь ошибка
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier) as? PhotosTableViewCell else { return UITableViewCell()}
            cell.delegate = self
            cell.backgroundColor = .lightGray
            return cell
        } else {
            
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { return UITableViewCell()}
            cell.setupCell(listPost[indexPath.row])
            cell.backgroundColor = .lightGray
            return cell
        }

    }
}

// MARK: - PhotosGalleryDelegate
extension ProfileViewController: PhotosGalleryDelegate {
    func openGallery() {
        print(#function)
        let galleryVC = PhotosViewController()
        //galleryVC.allPhotos = Photo.makeCollectionPhotos()
        navigationController?.pushViewController(galleryVC, animated: true)
    }
}
