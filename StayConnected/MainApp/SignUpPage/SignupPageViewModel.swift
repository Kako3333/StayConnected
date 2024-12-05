//
//  SignupPageViewModel.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 28.11.24.
//
import Foundation
import NetworkPackage

struct CustomUserRequest: Codable {
    let first_name: String
    let last_name: String
    let email: String
    let password: String
}

struct CustomUserResponse: Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let email: String
    let score: Int?
    let answered_questions: Int?
}

class SignupViewModel {
    
    var fullName: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkPackage()) {
            self.networkService = networkService
        }
    
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
    
    func signup(
        fullName: String,
        email: String,
        password: String,
        completion: @escaping (Result<CustomUserResponse, Error>) -> Void
    ) {
        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty else {
            completion(.failure(NSError(domain: "Validation failed", code: 400, userInfo: [NSLocalizedDescriptionKey: "Fields cannot be empty"])))
            return
        }
        
        let nameComponents = fullName.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        guard nameComponents.count == 2 else {
            completion(.failure(NSError(domain: "Invalid full name format", code: 400, userInfo: [NSLocalizedDescriptionKey: "Enter full name with first and last name"])))
            return
        }
        
        let firstName = String(nameComponents[0])
        let lastName = String(nameComponents[1])
        
        let userRequest = CustomUserRequest(
            first_name: firstName,
            last_name: lastName,
            email: email,
            password: password
        )
        
        let postUrl = "http://ios-stg.stayconnected.digital/api/users/"
        
        // Perform the signup request with the correct model type
        networkService.postData(to: postUrl, modelType: CustomUserResponse.self, requestBody: userRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userResponse):
                    // Now userResponse is correctly typed as CustomUserResponse
                    print("Signup successful! User details:")
                    print("ID: \(userResponse.id)")
                    print("Email: \(userResponse.email)")
                    print("Name: \(userResponse.first_name) \(userResponse.last_name)")
                    completion(.success(userResponse))
                case .failure(let error):
                    print("Signup failed with error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }
}
