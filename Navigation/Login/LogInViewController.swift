//
//  LogInViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 27.03.2023.
//

import UIKit
import FirebaseAuth



final class LogInViewController: UIViewController {
    
    // MARK: - Public properties
    
   
    
    weak var coordinator: LoginCoordinatorProtocol?
    
    // MARK: - Privte properties
    
    private let checkerService: CheckerServiceProtocol
    
    private var loginDelegate: LoginViewControllerDelegate?
    
    private let validator = Validator.shared
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var loginTextField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.textColor = .black
        login.layer.backgroundColor = UIColor.systemGray6.cgColor
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.5
        login.leftViewMode = .always
        let localizedTextField = NSLocalizedString("LoginTextField", comment: "testing")
        login.placeholder = localizedTextField
        login.autocapitalizationType = .none
        login.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        return login
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.textColor = .black
        password.layer.backgroundColor = UIColor.systemGray6.cgColor
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.5
        password.leftViewMode = .always
        let localizedPlaceholderPassword = NSLocalizedString("PlaceholderPassword", comment: "testing")
        password.placeholder = localizedPlaceholderPassword
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        return password
        
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(rgb: 0x4885CC)
        button.layer.cornerRadius = 10
        let localizedLogInButton = NSLocalizedString("LogInButton", comment: "testing")
        button.setTitle(localizedLogInButton, for: .normal)
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(rgb: 0x4885CC)
        button.layer.cornerRadius = 10
        let localizedregistrationButton = NSLocalizedString("registrationButton", comment: "testing")
        button.setTitle(localizedregistrationButton, for: .normal)
        button.addTarget(self, action: #selector(self.didTapRegistrationButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycles
    
    init(loginDelegate: LoginViewControllerDelegate, checkerService: CheckerServiceProtocol) {
        self.loginDelegate = loginDelegate
        self.checkerService = checkerService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupgestureRecognizer()
        Auth.auth().addStateDidChangeListener{ auth, user in // заходим в профайл если данные получены корректно
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - Private methods

    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(stackView)
        setupStackView()
        scrollView.addSubview(logInButton)
        scrollView.addSubview(registrationButton)
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(self.loginTextField)
        stackView.addArrangedSubview(self.passwordTextField)
    }
    
    private func setupgestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapSuperView))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func makeWrongAlert(massage: String) {
        let localizedWrongAlertTitle = NSLocalizedString("WrongAlertTitle", comment: "testing")
        let alertController = UIAlertController(
            title: localizedWrongAlertTitle,
            message: massage,
            preferredStyle: .alert
        )
        let localizedAlertOkAction = NSLocalizedString("AlertOkAction", comment: "testing")
        let okAction = UIAlertAction(title: localizedAlertOkAction, style: .cancel)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            registrationButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registrationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc
    private func kbdShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            let loginButtonBottomPointY = self.logInButton.frame.origin.y + self.logInButton.frame.height
            let keyboardOriginY = self.scrollView.frame.height - keyboardHeight
            let yOffset = keyboardOriginY < loginButtonBottomPointY ? loginButtonBottomPointY - keyboardOriginY + 16 : 0
            print(keyboardOriginY)
            print(loginButtonBottomPointY)
            self.scrollView.setContentOffset(CGPoint(x: 0, y: yOffset), animated: true)
        }
    }
    
    @objc
    private func kbdHide() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc
    private func didTapSuperView() {
        self.view.endEditing(true)
    }
    
    @objc
    private func didTapButton() { //не заходит в систему даже если данные правильные
        let localizedTextInAlertWrong = NSLocalizedString("TextInAlertWrong", comment: "testing")
        let login = self.loginTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        checkerService.checkCredentials(email: login, pass: password) { user, errorString in
            guard let user else {
                self.makeWrongAlert(massage: errorString ?? localizedTextInAlertWrong)
                return
            }
            self.coordinator?.goToTabBarController()
        }
        RealmManager.shared.save(login: login, pass: password)
//        var result: Bool? = true
//        do {
//            result = try loginDelegate?.check(login: login, password: password)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        if result! {
//            self.coordinator?.goToTabBarController()
//        } else {
//            self.makeWrongAlert(massage: "Login or password is not correct")
//        }
//
        //        checker.checkCredentials(email: login, pass: password) { [weak self] authDataResult, error in
        //            guard let self = self else {return}
        //            if let error {
        //                print(error.localizedDescription)
        //                self.makeWrongAlert(massage: "Login or password is not correct")
        //                return
        //            }
        //            self.coordinator?.goToTabBarController()
        //        }
    }
    
    
    
    @objc
    private func didTapRegistrationButton() {
        let localizedRegistrationButtonNotCorrectPass = NSLocalizedString("RegistrationButtonNotCorrectPass", comment: "testing")
        TextPicker.defaultPicker.showSignupPicker(in: self) { login, pass, pass2 in
            if login != "" && pass != "" && pass2 != "" {
                if pass != pass2 {
                    self.makeWrongAlert(massage: localizedRegistrationButtonNotCorrectPass)

                    return
                }
                
                self.checkerService.signUp(email: login, pass: pass) { check , errorString in
                    guard let errorString else {
                        self.coordinator?.goToTabBarController()
                        return
                    }
                    
                    self.makeWrongAlert(massage: errorString)
                }
            }
            else {
                let localizedMakeWrongAlert = NSLocalizedString("MakeWrongAlert", comment: "testing")
                self.makeWrongAlert(massage: localizedMakeWrongAlert)
            }
        }
    }
    
    
    
    //        do {
    //            let user = try self.loginDelegate.check(login: self.loginTextField.text, password: self.passwordTextField.text)
    //            self.coordinator?.goToTabBarController()
    //        } catch {
    //            if let error = error as? LoginViewControllerDelegateError {
    //                self.makeWrongAlert(massage: error.errorDescription)
    //            } else {
    //                self.makeWrongAlert(massage: "Неизвестная ошибка")
    //            }
    //        }
}

