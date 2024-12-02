//
//  MainTabBarController.swift
//  StayConnected
//
//  Created by Tiko on 29.11.24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupViewControllers()
    }
    
    private func setupTabBarAppearance() {
        tabBar.backgroundColor = UIColor(hex: "#F3F2F1")
        tabBar.tintColor = UIColor(named: "PrimaryColor")
        tabBar.unselectedItemTintColor = UIColor.lightGray
        
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupViewControllers() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "homeIcon"),
            selectedImage: UIImage(named: "homeIconSelected")
        )
        
        let leaderboardVC = UIViewController()
        leaderboardVC.view.backgroundColor = .white
        leaderboardVC.title = "Leaderboard"
        leaderboardVC.tabBarItem = UITabBarItem(
            title: "Leaderboard",
            image: UIImage(named: "leaderboardIcon"),
            selectedImage: UIImage(named: "leaderboardIconSelected")
        )
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profileIcon"),
            selectedImage: UIImage(named: "profileIconSelected")
        )
        
        viewControllers = [homeVC, leaderboardVC, profileVC]
    }
}


