//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 31.03.2023.
//

import UIKit

protocol PhotosGalleryDelegate: AnyObject {
    func openGallery()
}

class PhotosTableViewCell: UITableViewCell {

    weak var delegate: PhotosGalleryDelegate?
    
    private let collectionPhotos = Photo.makeCollectionPhotos()
    
    private lazy var imageCollectionView: UIView = { // вью самой коллекции на 4 картинки
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var namelabel: UILabel = { // название Photos заголовок ячейки с 4 картинками
        let name = UILabel()
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        name.text = "Photos"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var button: UIButton = { // кнопка для перехода в библиотеку картинок
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Кнопка"), for: .normal) // .setTitle("Кнопка")
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func tapButton() {
        print("TAP")
        
        self.delegate?.openGallery()
        print(#function)
    }
    
    private lazy var imageCollection: UICollectionView = { // коллекция картинок
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // горизонтальное расположение
        let imageCollection = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout
        )
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.delegate = self // кто будет реагировать на делегиварование
        imageCollection.dataSource = self // хранилище дванных
        imageCollection.backgroundColor = .lightGray
        imageCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return imageCollection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { // момент создания ячеки блока с фотографиями
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init(coder: NSCoder) { // обязательный инициализатор
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        let labelinset: CGFloat = 12
        
        [namelabel, button, imageCollection].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            namelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelinset),
            namelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelinset),
            namelabel.bottomAnchor.constraint(equalTo: imageCollection.topAnchor, constant: -labelinset),
            
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelinset),
            //button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelinset),
            button.centerYAnchor.constraint(equalTo: namelabel.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 20),
            button.widthAnchor.constraint(equalToConstant: 20),
            
            imageCollection.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: labelinset),
            imageCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelinset),
            imageCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelinset),
            imageCollection.heightAnchor.constraint(equalToConstant: 100),
            imageCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelinset)
            
        ])
    }
    
}

// MARK: - UICOllectionViewDelegateFlowLayout

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat {return 8}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 5) / 4 // от ширины экрана отнимает все отступы (включая первый и последний) и делим на количество элементов
        return CGSize(width: width, height: width) // возвращаем квадратный размер, потому что картинки по ТЗ квадратные
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset // минимальный отступ между элементами UICollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }

}


// MARK: - UICollectionViewDataSource

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else {return UICollectionViewCell()}
        cell.setupCollectionCell(collectionPhotos[indexPath.item].image!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionPhotos.count
    }
    
}
