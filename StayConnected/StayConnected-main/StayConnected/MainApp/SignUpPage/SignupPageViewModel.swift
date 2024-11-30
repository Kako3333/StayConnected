//
//  SignupPageViewModel.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 28.11.24.
//

import Foundation

class SignupViewModel {
    
    var fullName: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    func validateFullName() -> Bool {
        return !fullName.isEmpty
    }
    
    func validateEmail() -> Bool {
        // Basic email validation
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    func validatePassword() -> Bool {
        // password contains more than 6 letters and first letter is uppercase
        return password.count >= 6 && password.first?.isUppercase == true
    }
    
    func validateConfirmPassword() -> Bool {
        return password == confirmPassword
    }
    
    func validateSignup() -> Bool {
        return validateFullName() && validateEmail() && validatePassword() && validateConfirmPassword()
    }
}
