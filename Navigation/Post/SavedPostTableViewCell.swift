//
//  SacvedPostTableViewCell.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 12.08.2023.
//

import UIKit
import StorageService

class SavedPostTableViewCell: UITableViewCell {
    
    private lazy var nameAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(post: Post) {
        self.nameAuthor.text = post.author
    }
    
    private func layout() {
        
        contentView.addSubview(nameAuthor)
        
        NSLayoutConstraint.activate([
            nameAuthor.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameAuthor.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nameAuthor.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameAuthor.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
    }
}
