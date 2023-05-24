//
//  LogInViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 27.03.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let notificationCenter = NotificationCenter.default
    
    enum ValidationError: Error {
            case invalidCredentials
        }

    var loginDelegate: LoginViewControllerDelegate!
        
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var loginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var loginText: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.textColor = .black
        login.layer.backgroundColor = UIColor.systemGray6.cgColor
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.5
        login.leftViewMode = .always
        login.placeholder = "Login"
        login.autocapitalizationType = .none
        login.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        return login
    }()
    
    private lazy var loginPassword: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.textColor = .black
        password.layer.backgroundColor = UIColor.systemGray6.cgColor
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.5
        password.leftViewMode = .always
        password.placeholder = "Password"
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        return password

    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.layer.cornerRadius = 10
        
        
        stackView.addArrangedSubview(self.loginText)
        stackView.addArrangedSubview(self.emptyView)
        stackView.addArrangedSubview(self.loginPassword)
        
        return stackView
    }()
 
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(rgb: 0x4885CC)
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        return button
    }()
    
    @objc private func setStatus() {
        let login = loginText.text ?? ""
        let pass = loginPassword.text ?? ""
        if self.loginDelegate.check(login: login, password: pass) {
            let profileVC = ProfileViewController()
            #if DEBUG
            profileVC.currentUser = TestUserService(login: loginText.text ?? "Not login").user
            navigationController?.pushViewController(profileVC, animated: true)
            #else
            profileVC.currentUser = CurrentUserService(login: loginText.text ?? "Not login").user
            navigationController?.pushViewController(profileVC, animated: true)
            #endif
        }
        else {
            let alert = UIAlertController(title: "Bad auth", message: "Пользователь с таким логином/паролем не найден", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func kbdShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            
            let loginButtonBottomPointY = self.logInButton.frame.origin.y + 16
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < loginButtonBottomPointY ? loginButtonBottomPointY - keyboardOriginY + 16 : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    @objc private func kbdHide() {
        scrollView.contentOffset = .zero
        
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(loginView)
        [logoImage, stackView, logInButton].forEach{loginView.addSubview($0)} // удалила отсюда loginPassword, loginText,
        let constant: CGFloat = 16
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loginView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            loginView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            loginView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            loginView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            loginView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImage.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            
            
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: constant),
            stackView.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -constant),
            stackView.heightAnchor.constraint(equalToConstant: 100),

            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: constant),
            logInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: constant),
            logInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -constant),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -constant)
        ])
        
    }

}

