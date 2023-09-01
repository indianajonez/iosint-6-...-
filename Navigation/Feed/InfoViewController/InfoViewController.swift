//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.

import UIKit

class InfoViewController: UIViewController{
    
    // MARK: - Public properties
    
    var coordinator: CoordinatorProtocol?
    
    private let infoNetworkService: InfoNetworkServiceProtocol
    
    private lazy var fullNameLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = ""
           label.textColor = .black
           label.textAlignment = .center
           label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
           return label
       }()
    
    private lazy var fullNameLabelTwo: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = ""
           label.textColor = .black
           label.textAlignment = .center
           label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
           return label
       }()
    
    let locolizedCancelAlertButton = NSLocalizedString("CancelAlertButton", comment: "TestingLocolizationString")
    // не понимаю что делать, выдает ошибку 
    let cancelAction = UIAlertAction(title: "Отмена", style: .destructive) { _ in
        print("отмена выхода из просмотра информации")
    }
    
    
    // MARK: - Lifecycles
    init( infoNetworkService: InfoNetworkServiceProtocol) {
        self.infoNetworkService = infoNetworkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        makeButton()
        layout()
        infoNetworkService.requestTaskOne(number: 2) { result in
            switch result {
            case .success(let newTitle):
                self.fullNameLabel.text = newTitle
            case .failure(let error):
                print(error)
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.infoNetworkService.requestTaskTwo { star in
                self.fullNameLabelTwo.text = star.orbital_period
            }

        }
//        NetworkManager.requestTaskOne { array in
//            self.fullNameLabelTwo.text = array?[0].title
//        }
        
//        NetworkManager.requestTaskTwo { array in
//            self.fullNameLabel.text = array[0].title
//        }
    }
    
    private func layout() {
        
        view.addSubview(fullNameLabel)
        view.addSubview(fullNameLabelTwo)
        
        NSLayoutConstraint.activate([
            fullNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            fullNameLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -50),
            
            fullNameLabelTwo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            fullNameLabelTwo.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -230)
        ])
    }
    
    
    // MARK: - Public methods
    
    func makeButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let localizedCloseButton = NSLocalizedString("CloseButton", comment: "TestingLocolizationString")
        button.center = view.center
        button.setTitle(localizedCloseButton, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    // MARK: - Private methods
    
    @objc
    private func tapAction(){
        let localizedTitleAlert = NSLocalizedString("TitleAlert", comment: "TestingLocolizationString")
        let locolizedMessageAlert = NSLocalizedString("MessageAlert", comment: "TestingLocolizationString")
        let locolizedAlertButton = NSLocalizedString("AlertButton", comment: "TestingLocolizationString")
        let alert = UIAlertController(
            title: localizedTitleAlert,
            message: locolizedMessageAlert,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: locolizedAlertButton,
            style: .default
        ){
            _ in
            self.popoverPresentationController
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
