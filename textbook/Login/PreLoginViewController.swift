//
//  PreLoginViewController.swift
//  textbook
//
//  Created by Jessica Wu on 2/3/21.
//  Copyright © 2021 Anya Ji. All rights reserved.
//

import UIKit

class PreLoginViewController: UIViewController {
    
    let aqua: UIColor = UIColor(red: 0.168, green: 0.543, blue: 0.567, alpha: 1)
    let gray: UIColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1)
    let pink: UIColor = UIColor(red: 1, green: 0.479, blue: 0.479, alpha: 1)
    
    var registerButton: UIButton!
    var loginButton: UIButton!
    var titleLabel: UILabel!
    var welcomeText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        setupBackground()
    }
    
    func setupBackground() {
        let background = UIImage(named: "home_background")
        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.image = background
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func setupViews() {
        
        titleLabel = UILabel()
        titleLabel.text = "Give and Take with \nBookSmart"
        titleLabel.textColor = aqua
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.isUserInteractionEnabled = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        welcomeText = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        welcomeText.attributedText = NSMutableAttributedString(string: "Welcome to BookSmart, an application made by Cornellians. Let’s help you achieve your goals.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        welcomeText.textColor = gray
        welcomeText.font = UIFont.systemFont(ofSize: 18)
        welcomeText.numberOfLines = 0
        welcomeText.lineBreakMode = .byWordWrapping
        welcomeText.isUserInteractionEnabled = false
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeText)
        
        registerButton = UIButton()
        registerButton.layer.cornerRadius = 20
        registerButton.layer.masksToBounds = false
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = pink.cgColor
        registerButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        registerButton.layer.shadowOpacity = 1
        registerButton.layer.shadowRadius = 4
        registerButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        registerButton.setTitle("Create Account", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = pink
        registerButton.isUserInteractionEnabled = true
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        
        loginButton = UIButton()
        loginButton.layer.cornerRadius = 20
        loginButton.layer.masksToBounds = false
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.shadowRadius = 4
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = .white
        loginButton.isUserInteractionEnabled = true
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
    }
    
    func setupConstraints() {
        
        let height: CGFloat = view.frame.height
        let width: CGFloat = view.frame.width
        let padding: CGFloat = width/15
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: width/10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -width/10),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: height*0.1)
        ])
        
        NSLayoutConstraint.activate([
            welcomeText.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            welcomeText.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            welcomeText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: height*0.02),
            welcomeText.heightAnchor.constraint(equalToConstant: height*0.12)
        ])
        
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: width*0.88),
            registerButton.heightAnchor.constraint(equalToConstant: height*0.0625),
            registerButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: width*0.88),
            loginButton.heightAnchor.constraint(equalToConstant: height*0.0625),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -height*0.03)
        ])

    }
    
    @objc func registerButtonTapped() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func loginButtonTapped () {
        self.navigationController?.pushViewController(NewLoginViewController(), animated: true)
    }

}
