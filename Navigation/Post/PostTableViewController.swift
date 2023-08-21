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
    
    private var coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    private let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PostStorage")
    private var dataForTable: [Post] = []
    
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
        title = "Сохраненные посты"
//        tablePosts.rowHeight = 200
        getFromCoreData()
        self.tablePosts.reloadData()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFromCoreData()
        self.tablePosts.reloadData()
    }
    
    private func getFromCoreData() {
        dataForTable = []
        let all = coreDataManager.fetchAllData(fetchRequest)
        for post in all {
            dataForTable.append(Post(data: post))
        }
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
}

extension PostTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataForTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tablePosts.dequeueReusableCell(withIdentifier: String(describing: SavedPostTableViewCell.self), for: indexPath) as? SavedPostTableViewCell else {return UITableViewCell()}
        cell.setup(post: dataForTable[indexPath.row])
        return cell
    }
    
    
}
