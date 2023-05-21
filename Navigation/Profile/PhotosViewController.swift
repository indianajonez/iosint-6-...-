//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 05.04.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
// Создайте для PhotosViewController экземпляр класса ImagePublisherFacade.
    private var imageList: [UIImage] = []
    private var imagePublisherFacade: ImagePublisherFacade = ImagePublisherFacade()

    
// Завершив установку фреймворка, необходимо подписать класс PhotosViewController на протокол ImageLibrarySubscriber и реализовать через extension его единственный метод.
    
    lazy var allPhotos = Photo.makeCollectioinPhotos()
    
    private lazy var imageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let imageCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return imageCollection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Gallery"
        navigationController?.navigationBar.isHidden = false
// Запустите сценарий наполнения коллекции изображениями через метод addImagesWithTimer. Поставьте задержку времени не менее 0.5 секунд, чтобы наблюдать, как этот паблишер работает. Количество повторений RepeatCount нужно поставить более 10, чтобы вся коллекция постепенно заполнилась фото.
    
        // Начать генерацию изображений с помощью метода addImagesWithTimer
//        self.imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: allPhotos)
        self.imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 20)
        layout()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        imagePublisherFacade.subscribe(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imagePublisherFacade.removeSubscription(for: self)
        imagePublisherFacade.rechargeImageLibrary()
        
    }
    // Где-то в подходящем методе (подумайте где) необходимо отменить подписку, так как хорошее правило работы с подписками заключается в том, что если где-то в вашем приложении подписка добавлена, то где-то она должна быть потенциально завершена после окончания своей работы.
    
    private func layout() {
        view.addSubview(imageCollection)
        
        NSLayoutConstraint.activate([
            imageCollection.topAnchor.constraint(equalTo: view.topAnchor),
            imageCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        cell.setupCollectionCell(imageList[indexPath.item])
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat {return 8}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (imageCollection.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
}
    
    // MARK: - ImageLibrarySubscriber
    
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        self.imageList = images
        imageCollection.reloadData()
        
    }
}


        

    

