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
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionOfPosts: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageInPosts: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var likesInPosts: UILabel = {
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
    
    func setup(post: Post) {
        self.nameAuthor.text = post.author
        self.imageInPosts.image = (UIImage(named: post.image))
        self.descriptionOfPosts.text = post.description
        self.postLikesCount.text = String(post.likes)
        self.postViewsCount.text = String(post.views)
        
    }
    
    private func layout() {
        [nameAuthor,  postViewsCount, descriptionOfPosts, postLikesCount, likesInPosts, imageInPosts, postViews].forEach({contentView.addSubview($0)})
        //tapLikeButton,
        
        let labelInset: CGFloat = 16
        let imageInset: CGFloat = 12
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        NSLayoutConstraint.activate([
            nameAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelInset),
            nameAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelInset),
            nameAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelInset),
            
            imageInPosts.topAnchor.constraint(equalTo: nameAuthor.bottomAnchor, constant: imageInset),
            imageInPosts.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageInPosts.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageInPosts.heightAnchor.constraint(equalToConstant: screenWidth),
            imageInPosts.widthAnchor.constraint(equalToConstant: screenWidth),
            
            descriptionOfPosts.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelInset),
            descriptionOfPosts.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelInset),
            descriptionOfPosts.topAnchor.constraint(equalTo: imageInPosts.bottomAnchor, constant: labelInset),

            likesInPosts.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelInset),
            likesInPosts.topAnchor.constraint(equalTo: descriptionOfPosts.bottomAnchor, constant: labelInset),
            likesInPosts.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),

            postLikesCount.topAnchor.constraint(equalTo: descriptionOfPosts.bottomAnchor, constant: labelInset),
            postLikesCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            postLikesCount.leadingAnchor.constraint(equalTo: likesInPosts.trailingAnchor),

            postViews.topAnchor.constraint(equalTo: descriptionOfPosts.bottomAnchor, constant: labelInset),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            postViews.trailingAnchor.constraint(equalTo: postViewsCount.leadingAnchor),

            postViewsCount.topAnchor.constraint(equalTo: descriptionOfPosts.bottomAnchor, constant: labelInset),
            postViewsCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset),
            postViewsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelInset),
            
//            tapLikeButton.topAnchor.constraint(equalTo: descriptionOfPosts.bottomAnchor, constant: labelInset),
//            tapLikeButton.leadingAnchor.constraint(equalTo: postLikesCount.trailingAnchor, constant: labelInset),
//            tapLikeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset)
        ])
    }
}

