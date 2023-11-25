//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    // MARK: - Privte properties
    
    private var counter = 0
    private var isTimerStarted = false
    private var timer: Timer?
    private var listPost = Post2.make()
    private var listPhoto = Photo.makeCollectionPhotos()
    private var subscriber = RunloopViewController()

    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.createColor(lightMode: .lightGray, darkMode: .black)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return table
    }()
    
    // MARK: - Public properties
    
    var currentUser: User?
    var coordinator: CoordinatorProtocol?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        start()
        super.viewDidLoad()
        #if DEBUG
        view.backgroundColor = UIColor.createColor(lightMode: .lightGray, darkMode: .black)
        #else
        view.backgroundColor = UIColor.createColor(lightMode: .lightGray, darkMode: .black)
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConstraints()
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Private methods
    
    private func start() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
            guard let self else { return }

            DispatchQueue.main.async {
                print("end present")
                self.navigationController?.pushViewController(self.subscriber, animated: true)
            }
        }
    }
    
//    private func start() {
//        DispatchQueue.global().async { [weak self] in
//            guard let self else { return }
//
//            self.timer = Timer.scheduledTimer(
//                timeInterval: 5.0,
//                target: self,
//                selector: #selector(self.showView),
//                userInfo: nil,
//                repeats: false)
//
//            guard let timer = self.timer else { return }
//
//            RunLoop.current.add(timer, forMode: .common)
//            RunLoop.current.run()
//        }
//    }
//
//    @objc private func showView() {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else {return }
//            //self.coordinator.forward(to: self.subscriber)
//
//            print("end present")
//           //self.navigationController?.pushViewController(self.subscriber, animated: true)
//            self.coordinator?.forward(to: RunloopViewController())
//            //coordinator?.present(to: subscriber)
//        }
//    }
//
    
    private func setupConstraints() {
        
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
        UITableView.automaticDimension // автоматическая высока в зависимости от контента
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileHeaderView()
        header.setView(user: currentUser)
        header.backgroundColor = UIColor.createColor(lightMode: .lightGray, darkMode: .black)
        return section == 0 ? header : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return section == 0 ? 220 : 0
        }
}



// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : listPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier) as? PhotosTableViewCell else { return UITableViewCell()}
            cell.delegate = self
            cell.backgroundColor = UIColor.createColor(lightMode: .lightGray, darkMode: .black)
            return cell
        } else {
            
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { return UITableViewCell()}
            cell.setupCell(listPost[indexPath.row])
            cell.backgroundColor = UIColor.createColor(lightMode: .lightGray, darkMode: .black)
            return cell
        }
        
    }
}



// MARK: - PhotosGalleryDelegate

extension ProfileViewController: PhotosGalleryDelegate {
    
    func openGallery() {
        print(#function)
        let galleryVC = PhotosViewController()
        navigationController?.pushViewController(galleryVC, animated: true)
    }
}
