//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.04.2023.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private var post: Post!
    
    private var isTapped = false
    
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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postLikes: UILabel = {
        let likes = UILabel()
        let localizedPostLikesLabel = NSLocalizedString("PostLikesLabel", comment: "testing")
        likes.text = localizedPostLikesLabel
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
        let localizedPostViewsLabel = NSLocalizedString("PostViewsLabel", comment: "testing")
        views.text = localizedPostViewsLabel
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    private lazy var postViewsCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tapLikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemRed
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(addLikes), for: .touchUpInside)
        
        return button
    }()

    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstrains()
//        setupGestures()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    
    func setupCell(_ post: Post) {
        postNameLabel.text = post.author
        postImage.image = (UIImage(named: post.image))
        posrDescLabel.text = post.description
        postLikesCount.text = String(post.likes)
        postViewsCount.text = String(post.views)
        self.post = post
    }
    
    
    // MARK: - Private methods
    
    
//    @objc private func setupGestures() {
//        let tapLikes = UITapGestureRecognizer(target: self, action: #selector(addLikes))
//        postLikes.addGestureRecognizer(tapLikes)
//        postLikes.isUserInteractionEnabled = true
//    }
    
    @objc private func addLikes() {

        CoreDataManager.shared.addToFavorites(originPost: post) 
        
        isTapped.toggle()
        let name = isTapped ? "heart.fill" : "heart"
        tapLikeButton.setImage(UIImage(systemName: name), for: .normal)
    }
    
    
    private func setupConstrains() {
        [postNameLabel, postImage, posrDescLabel, postLikes, postLikesCount, postViews, postViewsCount, tapLikeButton].forEach({contentView.addSubview($0)})
        
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
            postViewsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelInset),
            
            tapLikeButton.topAnchor.constraint(equalTo: posrDescLabel.bottomAnchor, constant: labelInset),
            tapLikeButton.leadingAnchor.constraint(equalTo: postLikesCount.trailingAnchor, constant: labelInset),
            tapLikeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelInset)
        ])
    }
}

