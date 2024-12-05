//
//  ViewController.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 28.11.24.
//

import UIKit

//test@example.com
// Password123

extension Notification.Name {
    static let loginSuccess = Notification.Name("loginSuccess")
}

class LoginPageVC: UIViewController, UITextFieldDelegate {
    
    private let viewModel = LoginPageViewModel()
    
    private let loginLabel: UILabel = {
        var loginLabel = UILabel()
        loginLabel.text = "Log in"
        loginLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        loginLabel.textColor = .black
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        return loginLabel
    }()
    
    private let emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.text = "Email"
        emailLabel.textColor = .lightGrayText
        emailLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        return emailLabel
    }()
    
    private let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.layer.cornerRadius = 12
        emailTextField.text = "Username"
        emailTextField.textColor = .lightGrayText
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailTextField.backgroundColor = .white
        
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.lightGrayText.cgColor
        
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()
    
    private let passwordLabel: UILabel = {
        let passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.textColor = .lightGrayText
        passwordLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        return passwordLabel
    }()
    
    private let togglePasswordVisibilityButton: UIButton = {
        let togglePasswordVisibilityButton = UIButton(type: .custom)
        togglePasswordVisibilityButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        togglePasswordVisibilityButton.tintColor = .black
        togglePasswordVisibilityButton.translatesAutoresizingMaskIntoConstraints = false
        return togglePasswordVisibilityButton
    }()
    
    private let forgotPasswordButton: UIButton = {
        let forgotPasswordButton = UIButton(type: .custom)
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(.lightGrayText, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        return forgotPasswordButton
    }()
    
    private let newToStayConnectedLabel: UILabel = {
        let newToStayConnectedLabel = UILabel()
        newToStayConnectedLabel.text = "New To StayConnected?"
        newToStayConnectedLabel.textColor = .lightGrayText
        newToStayConnectedLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        newToStayConnectedLabel.translatesAutoresizingMaskIntoConstraints = false
        return newToStayConnectedLabel
    }()
    
    private let signUpButton: UIButton = {
        let signUpButton = UIButton(type: .custom)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.lightGrayText, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        return signUpButton
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.text = "YourPassword"
        passwordTextField.textColor = .passwordTextColor
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordTextField.backgroundColor = .white
        passwordTextField.isSecureTextEntry = true
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.lightGrayText.cgColor
        
        let lockIcon = UIImageView(image: UIImage(named: "lockIcon"))
        lockIcon.contentMode = .scaleAspectFit
        lockIcon.tintColor = .lightGrayText
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: passwordTextField.frame.height))
        lockIcon.frame = CGRect(x: 20, y: (passwordTextField.frame.height - 20) / 2, width: 20, height: 20)
        paddingView.addSubview(lockIcon)
        
        passwordTextField.leftView = paddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordTextField
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.layer.cornerRadius = 12
        loginButton.backgroundColor = .darkButtonColor
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelBindings()
        navigationController?.isNavigationBarHidden = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(loginLabel)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(newToStayConnectedLabel)
        view.addSubview(signUpButton)
        configureButton()
        passwordTextField.addSubview(togglePasswordVisibilityButton)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            loginLabel.widthAnchor.constraint(equalToConstant: 111),
            loginLabel.heightAnchor.constraint(equalToConstant: 35),
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 70),
            emailLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 6),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 6),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            
            togglePasswordVisibilityButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -10),
            togglePasswordVisibilityButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            togglePasswordVisibilityButton.widthAnchor.constraint(equalToConstant: 40),
            togglePasswordVisibilityButton.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPasswordButton.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 110),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 10),
            
            newToStayConnectedLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            newToStayConnectedLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            
            signUpButton.centerYAnchor.constraint(equalTo: newToStayConnectedLabel.centerYAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -2),
            
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
        ])
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func configureButton() {
        signUpButton.addAction(UIAction(handler: { [weak self] action in
            self?.signupButtonPressed()
        }), for: .touchUpInside)
        
        togglePasswordVisibilityButton.addAction(UIAction(handler: { [weak self] action in
            self?.visibilityButtonPressed()
        }), for: .touchUpInside)
        
        loginButton.addAction(UIAction(handler: { [weak self] action in
            self?.loginButtonPressed()
        }), for: .touchUpInside)
    }
    
    func signupButtonPressed() {
        let signupPage = SignupPageVC()
        navigationController?.pushViewController(signupPage, animated: true)
    }
    
    @objc private func visibilityButtonPressed() {
        passwordTextField.isSecureTextEntry.toggle()
        
        let iconName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        togglePasswordVisibilityButton.setImage(UIImage(systemName: iconName), for: .normal)
    }
    
    func loginButtonPressed() {
        guard let username = emailTextField.text, let password = passwordTextField.text else {

            return
        }
        viewModel.login(email: username, password: password)
    }
    
    private func setupViewModelBindings() {
        viewModel.errorMessage = { [weak self] message in
            self?.showError(message)
        }
        
//        viewModel.onLoginSuccess = { [weak self] in
//            print("Login Successful!")
//            
//            NotificationCenter.default.post(name: .loginSuccess, object: nil)
//        }
    }
    
    private func showError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}







