//
//  LoginPageViewModel.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 28.11.24.
//
import UIKit

class LoginPageViewModel {
    
    var errorMessage: ((String) -> Void)?
    var onLoginSuccess: (() -> Void)?
    
    func login(email: String, password: String) {
        // Validate email and password
        if !isValidEmail(email) {
            errorMessage?("Email must contain '@'.")
            return
        }
        
        if !isValidPassword(password) {
            errorMessage?("Password must start with a capital letter, contain at least 8 characters, and include at least one digit.")
            return
        }
        
        // Proceed with login check if email and password are valid
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage?("Email and Password cannot be empty.")
            return
        }
        
        if email == "test@example.com" && password == "Password123" {
            onLoginSuccess?()
        } else {
            errorMessage?("Invalid email or password.")
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        // Simple email validation check
        return email.contains("@")
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        // Password validation: start with a capital letter, minimum 8 characters, must contain a digit
        let passwordRegex = "^[A-Z].{7,}$" // Starts with a capital letter, minimum 8 characters
        let digitRegex = ".*\\d.*" // Contains at least one digit
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let digitTest = NSPredicate(format: "SELF MATCHES %@", digitRegex)
        
        return passwordTest.evaluate(with: password) && digitTest.evaluate(with: password)
    }
}


