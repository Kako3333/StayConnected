//
//  LoginPageViewModel.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 28.11.24.
//
import UIKit
import NetworkPackage
import Security

struct TokenObtainPair: Codable {
    let email: String
    let password: String
}

struct TokenObtainPairResponse: Codable {
    let refresh: String
    let access: String
}

class LoginPageViewModel {
    var errorMessage: ((String) -> Void)?
    var onLoginSuccess: (() -> Void)?
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkPackage()) {
        self.networkService = networkService
    }
    
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
        
        let loginPayload = TokenObtainPair(email: email, password: password)
        print("Login Payload: \(loginPayload)")
        
        networkService.postData(
            to: "https://ios-stg.stayconnected.digital/api/token/",
            modelType: TokenObtainPairResponse.self,
            requestBody: loginPayload
        ) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let tokenResponse):
                    print("Tokens obtained: \(tokenResponse)")
                    self.saveTokens(tokenResponse)
                    self.navigateToMainTabBar()
                case .failure(let error):
                    self.errorMessage?("Login failed: \(error.localizedDescription)")
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func saveTokens(_ tokenResponse: TokenObtainPairResponse) {
        KeychainManager.save(key: "accessToken", value: tokenResponse.access)
        KeychainManager.save(key: "refreshToken", value: tokenResponse.refresh)
    }
    
    private func navigateToMainTabBar() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = MainTabBarController()
            window.makeKeyAndVisible()
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@")
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^[A-Z].{7,}$"
        let digitRegex = ".*\\d.*"
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let digitTest = NSPredicate(format: "SELF MATCHES %@", digitRegex)
        
        return passwordTest.evaluate(with: password) && digitTest.evaluate(with: password)
    }
}


