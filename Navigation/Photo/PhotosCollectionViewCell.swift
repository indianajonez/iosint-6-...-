//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 03.04.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private properties
    
    private lazy var imageCollectionCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    
    func setupCollectionCell(_ photo: UIImage) {
        imageCollectionCell.image = photo
    }
    
    
    // MARK: - Private methods
    
    private func setupConstrains() {
        
        contentView.addSubview(imageCollectionCell)
        
        NSLayoutConstraint.activate([
            imageCollectionCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCollectionCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollectionCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCollectionCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
