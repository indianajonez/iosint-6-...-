//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.04.2023.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    private lazy var postNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var posrDescLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postLikes: UILabel = {
        let likes = UILabel()
        likes.text = "Likes: "
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()
    
    private lazy var postLikesCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postViews: UILabel = {
        let views = UILabel()
        views.text = "Views: "
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    private lazy var postViewsCount: UILabel = {
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
    
    func setupCell(_ post: Post) {
        postNameLabel.text = post.author
        postImage.image = (UIImage(named: post.image))
        posrDescLabel.text = post.description
        postLikesCount.text = String(post.likes)
        postViewsCount.text = String(post.views)

    }
    
    private func layout() {
        [postNameLabel, postImage, posrDescLabel, postLikes, postLikesCount, postViews, postViewsCount].forEach({contentView.addSubview($0)})
        
        let labelInset: CGFloat = 16
        let imageInset: CGFloat = 12
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        NSLayoutConstraint.activate([
            postNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelInset),
            postNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelInset),
            postNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelInset),
            
            postImage.topAnchor.constraint(equalTo: postNameLabel.bottomAnchor, constant: imageInset),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: screenWidth),
            postImage.widthAnchor.constraint(equalToConstant: screenWidth),
            
            posrDescLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelInset),
            posrDescLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelInset),
            posrDescLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: labelInset),
            
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelInset),
            postLikes.topAnchor.constraint(equalTo: posrDescLabel.bottomAnchor, constant: labelInset),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            
            postLikesCount.topAnchor.constraint(equalTo: posrDescLabel.bottomAnchor, constant: labelInset),
            postLikesCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            postLikesCount.leadingAnchor.constraint(equalTo: postLikes.trailingAnchor),
            
            postViews.topAnchor.constraint(equalTo: posrDescLabel.bottomAnchor, constant: labelInset),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            postViews.trailingAnchor.constraint(equalTo: postViewsCount.leadingAnchor),
            
            postViewsCount.topAnchor.constraint(equalTo: posrDescLabel.bottomAnchor, constant: labelInset),
            postViewsCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            postViewsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelInset)
        ])
    }
}

