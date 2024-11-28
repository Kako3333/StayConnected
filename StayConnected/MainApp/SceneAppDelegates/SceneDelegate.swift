//
//  SceneDelegate.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 28.11.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        let launchScreenVC = LaunchScreenVC()
        window?.rootViewController = launchScreenVC
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let loginPageVC = LoginPageVC()
            let navigationController = UINavigationController(rootViewController: loginPageVC)
            navigationController.isNavigationBarHidden = true
            self.window?.rootViewController = navigationController
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    
}

