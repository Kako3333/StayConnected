//
//  SignupPageVC.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 28.11.24.
//

import UIKit

class SignupPageVC: UIViewController, UITextFieldDelegate {
    
    private let signupViewModel = SignupViewModel()
    
    private let signupLabel: UILabel = {
        var signupLabel = UILabel()
        signupLabel.text = "Sign Up"
        signupLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        signupLabel.textColor = .black
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        return signupLabel
    }()
    
    private let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "FullName"
        fullNameLabel.textColor = .lightGrayText
        fullNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    private let fullNameTextField: UITextField = {
        let fullNameTextField = UITextField()
        fullNameTextField.layer.cornerRadius = 12
        fullNameTextField.text = "Name"
        fullNameTextField.textColor = .lightGrayText
        fullNameTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        fullNameTextField.backgroundColor = .white
        
        fullNameTextField.layer.borderWidth = 1
        fullNameTextField.layer.borderColor = UIColor.lightGrayText.cgColor
        
        fullNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: fullNameTextField.frame.height))
        fullNameTextField.leftViewMode = .always
        fullNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return fullNameTextField
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
        passwordLabel.text = "Enter Password"
        passwordLabel.textColor = .lightGrayText
        passwordLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        return passwordLabel
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
    
    private let confirmPasswordLabel: UILabel = {
        let confirmPasswordLabel = UILabel()
        confirmPasswordLabel.text = "Confirm Password"
        confirmPasswordLabel.textColor = .lightGrayText
        confirmPasswordLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        return confirmPasswordLabel
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let confirmPasswordTextField = UITextField()
        confirmPasswordTextField.layer.cornerRadius = 12
        confirmPasswordTextField.text = "ConfirmPassword"
        confirmPasswordTextField.textColor = .passwordTextColor
        confirmPasswordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        confirmPasswordTextField.backgroundColor = .white
        confirmPasswordTextField.isSecureTextEntry = true
        
        confirmPasswordTextField.layer.borderWidth = 1
        confirmPasswordTextField.layer.borderColor = UIColor.lightGrayText.cgColor
        
        let lockIcon = UIImageView(image: UIImage(named: "lockIcon"))
        lockIcon.contentMode = .scaleAspectFit
        lockIcon.tintColor = .lightGrayText
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: confirmPasswordTextField.frame.height))
        lockIcon.frame = CGRect(x: 20, y: (confirmPasswordTextField.frame.height - 20) / 2, width: 20, height: 20)
        paddingView.addSubview(lockIcon)
        
        confirmPasswordTextField.leftView = paddingView
        confirmPasswordTextField.leftViewMode = .always
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return confirmPasswordTextField
    }()
    
    private let togglePasswordVisibilityButton: UIButton = {
        let togglePasswordVisibilityButton = UIButton(type: .custom)
        togglePasswordVisibilityButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        togglePasswordVisibilityButton.tintColor = .black
        togglePasswordVisibilityButton.translatesAutoresizingMaskIntoConstraints = false
        return togglePasswordVisibilityButton
    }()
    
    private let toggleConfirmPasswordVisibilityButton: UIButton = {
        let toggleConfirmPasswordVisibilityButton = UIButton(type: .custom)
        toggleConfirmPasswordVisibilityButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        toggleConfirmPasswordVisibilityButton.tintColor = .black
        toggleConfirmPasswordVisibilityButton.translatesAutoresizingMaskIntoConstraints = false
        return toggleConfirmPasswordVisibilityButton
    }()
    
    private let signUpButton: UIButton = {
        let signUpButton = UIButton()
        signUpButton.layer.cornerRadius = 12
        signUpButton.backgroundColor = .darkButtonColor
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        return signUpButton
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .black
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(signupLabel)
        view.addSubview(fullNameLabel)
        view.addSubview(fullNameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(signUpButton)
        view.addSubview(signUpButton)
        view.addSubview(backButton)
        passwordTextField.addSubview(togglePasswordVisibilityButton)
        confirmPasswordTextField.addSubview(toggleConfirmPasswordVisibilityButton)
        configureButton()
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            
            signupLabel.widthAnchor.constraint(equalToConstant: 130),
            signupLabel.heightAnchor.constraint(equalToConstant: 35),
            signupLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            signupLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
            
            fullNameLabel.topAnchor.constraint(equalTo: signupLabel.bottomAnchor, constant: 30),
            fullNameLabel.leadingAnchor.constraint(equalTo: fullNameTextField.leadingAnchor, constant: 6),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            fullNameTextField.heightAnchor.constraint(equalToConstant: 52),
            fullNameTextField.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 10),
            fullNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            fullNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            
            emailLabel.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 25),
            emailLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            passwordLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 52),
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 10),
            confirmPasswordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            confirmPasswordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            
            togglePasswordVisibilityButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -10),
            togglePasswordVisibilityButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            togglePasswordVisibilityButton.widthAnchor.constraint(equalToConstant: 40),
            togglePasswordVisibilityButton.heightAnchor.constraint(equalToConstant: 40),
            
            toggleConfirmPasswordVisibilityButton.rightAnchor.constraint(equalTo: confirmPasswordTextField.rightAnchor, constant: -10),
            toggleConfirmPasswordVisibilityButton.centerYAnchor.constraint(equalTo: confirmPasswordTextField.centerYAnchor),
            toggleConfirmPasswordVisibilityButton.widthAnchor.constraint(equalToConstant: 40),
            toggleConfirmPasswordVisibilityButton.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
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
        //signup
        signUpButton.addAction(UIAction(handler: { [weak self] action in
            self?.didTapSignUpButton()
        }), for: .touchUpInside)
        //togglePasswordTextField
        togglePasswordVisibilityButton.addAction(UIAction(handler: { [weak self] action in
            self?.passWordVisibilityButtonPressed()
        }), for: .touchUpInside)
        //toggleConfirmPasswordVisibilityButton
        toggleConfirmPasswordVisibilityButton.addAction(UIAction(handler: { [weak self] action in
            self?.confirmPasswordVisibilityButtonPressed()
        }), for: .touchUpInside)
        //backButton
        backButton.addAction(UIAction(handler: { [weak self] action in
            self?.backButtonPressed()
        }), for: .touchUpInside)
    }
    
    @objc private func didTapSignUpButton() {
        signupViewModel.fullName = fullNameTextField.text ?? ""
        signupViewModel.email = emailTextField.text ?? ""
        signupViewModel.password = passwordTextField.text ?? ""
        signupViewModel.confirmPassword = confirmPasswordTextField.text ?? ""
        
        if signupViewModel.validateSignup() {
            print("Signup successful")
            
            // Call the signup method
            signupViewModel.signup(fullName: signupViewModel.fullName,
                                   email: signupViewModel.email,
                                   password: signupViewModel.password) { result in
                switch result {
                case .success(let userResponse):
                    print("User signed up successfully! ID: \(userResponse.id)")
                    
                    // If signup is successful, navigate to LoginPageVC
                    DispatchQueue.main.async {
                        let loginPageVC = LoginPageVC()
                        self.navigationController?.pushViewController(loginPageVC, animated: true)
                    }
                    
                case .failure(let error):
                    print("Signup failed with error: \(error.localizedDescription)")
                    
                    DispatchQueue.main.async {
                        self.showAlert(message: "Signup failed: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            // If validation fails, show the alert
            showAlert(message: "Please check your input. All fields must be valid.")
        }
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func passWordVisibilityButtonPressed() {
        passwordTextField.isSecureTextEntry.toggle()
        let iconName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        togglePasswordVisibilityButton.setImage(UIImage(systemName: iconName), for: .normal)
    }
    
    func confirmPasswordVisibilityButtonPressed() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        let iconName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        toggleConfirmPasswordVisibilityButton.setImage(UIImage(systemName: iconName), for: .normal)
    }
    
}
