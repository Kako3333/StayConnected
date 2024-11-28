//
//  LaunchScreenVC.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 28.11.24.
//

import UIKit

class LaunchScreenVC: UIViewController {
    private let stayConnectedLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stayConnectedLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stayConnectedLabel: UILabel = {
        let label = UILabel()
        label.text = "Stay Connected"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 78/255, green: 83/255, blue: 162/255, alpha: 1)

        view.addSubview(stayConnectedLogo)
        view.addSubview(stayConnectedLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stayConnectedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stayConnectedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stayConnectedLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stayConnectedLogo.bottomAnchor.constraint(equalTo: stayConnectedLabel.topAnchor, constant: -20),
            stayConnectedLogo.widthAnchor.constraint(equalToConstant: 118),
            stayConnectedLogo.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
}
