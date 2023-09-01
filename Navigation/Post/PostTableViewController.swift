//
//  PostTableViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 12.08.2023.
//

import UIKit
import CoreData
import StorageService

class PostTableViewController: UIViewController {
    
    private var coreDataManager = CoreDataManager.shared
    private let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PostStorage")
//    private var dataForTable: [Post] = []
    
    private lazy var tablePosts: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(SavedPostTableViewCell.self, forCellReuseIdentifier: String(describing: SavedPostTableViewCell.self))
       
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let localizedSavedPostsTitle = NSLocalizedString("SavedPostsTitle", comment: "testing")
        title = localizedSavedPostsTitle
        coreDataManager.fetchFavorites()
        coreDataManager.didChangedPosts = { [weak self] in
            DispatchQueue.main.async {
                self?.tablePosts.reloadData()
            }
        }
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tablePosts.reloadData()
    }
    
    
    private func layout() {
        view.addSubview(tablePosts)
        
        NSLayoutConstraint.activate([
            tablePosts.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tablePosts.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tablePosts.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tablePosts.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
}



extension PostTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                coreDataManager.deletePost(post: coreDataManager.favoritesPost[indexPath.row])
            } else if editingStyle == .insert {
                
            }
        }
}

extension PostTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coreDataManager.favoritesPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tablePosts.dequeueReusableCell(withIdentifier: String(describing: SavedPostTableViewCell.self), for: indexPath) as? SavedPostTableViewCell else {return UITableViewCell()}
        cell.setup(post: coreDataManager.favoritesPost[indexPath.row])
        return cell
    }
    
    
}
