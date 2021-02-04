//
//  RegisterViewController.swift
//  textbook
//
//  Created by Jessica Wu on 2/3/21.
//  Copyright © 2021 Anya Ji. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let gray: UIColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1)
    let aqua: UIColor = UIColor(red: 0.168, green: 0.543, blue: 0.567, alpha: 1)
    let pink: UIColor = UIColor(red: 1, green: 0.479, blue: 0.479, alpha: 1)
    
    var startLabel: UILabel!
    var registerFName: UITextField!
    var registerLName: UITextField!
    var registerEmail: UITextField!
    var registerPassword: UITextField!
    var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
        startLabel = UILabel()
        startLabel.text = "Hi! Get Started."
        startLabel.textColor = aqua
        startLabel.font = UIFont.boldSystemFont(ofSize: 28)
        startLabel.isUserInteractionEnabled = false
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startLabel)
        
        registerFName = UITextField()
        let registerFNamePlaceHolder=NSAttributedString(string: "First Name", attributes:[NSAttributedString.Key.foregroundColor :UIColor.darkGray])
        registerFName.textColor = gray
        registerFName.attributedPlaceholder = registerFNamePlaceHolder
        registerFName.layer.backgroundColor = UIColor.white.cgColor
        registerFName.layer.borderColor = gray.cgColor
        registerFName.layer.borderWidth = 0.0
        registerFName.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        registerFName.layer.shadowOpacity = 1.0
        registerFName.layer.shadowRadius = 0.0
        registerFName.translatesAutoresizingMaskIntoConstraints = false
        registerFName.autocorrectionType = .no
        view.addSubview(registerFName)
        
        registerLName = UITextField()
        let registerLNamePlaceHolder=NSAttributedString(string: "Last Name", attributes:[NSAttributedString.Key.foregroundColor :UIColor.darkGray])
        registerLName.textColor = gray
        registerLName.attributedPlaceholder = registerLNamePlaceHolder
        registerLName.layer.backgroundColor = UIColor.white.cgColor
        registerLName.layer.borderColor = gray.cgColor
        registerLName.layer.borderWidth = 0.0
        registerLName.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        registerLName.layer.shadowOpacity = 1.0
        registerLName.layer.shadowRadius = 0.0
        registerLName.translatesAutoresizingMaskIntoConstraints = false
        registerLName.autocorrectionType = .no
        view.addSubview(registerLName)
        
        registerEmail = UITextField()
        let registerEmailPlaceHolder=NSAttributedString(string: "Student Email", attributes:[NSAttributedString.Key.foregroundColor :UIColor.darkGray])
        registerEmail.textColor = gray
        registerEmail.attributedPlaceholder = registerEmailPlaceHolder
        registerEmail.layer.backgroundColor = UIColor.white.cgColor
        registerEmail.layer.borderColor = gray.cgColor
        registerEmail.layer.borderWidth = 0.0
        registerEmail.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        registerEmail.layer.shadowOpacity = 1.0
        registerEmail.layer.shadowRadius = 0.0
        registerEmail.translatesAutoresizingMaskIntoConstraints = false
        registerEmail.autocapitalizationType = .none
        registerEmail.autocorrectionType = .no
        view.addSubview(registerEmail)
        
        registerPassword = UITextField()
        let registerPasswordPlaceHolder=NSAttributedString(string: "Password", attributes:[NSAttributedString.Key.foregroundColor :UIColor.darkGray])
        registerPassword.textColor = gray
        registerPassword.attributedPlaceholder = registerPasswordPlaceHolder
        registerPassword.layer.backgroundColor = UIColor.white.cgColor
        registerPassword.layer.borderColor = gray.cgColor
        registerPassword.layer.borderWidth = 0.0
        registerPassword.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        registerPassword.layer.shadowOpacity = 1.0
        registerPassword.layer.shadowRadius = 0.0
        registerPassword.translatesAutoresizingMaskIntoConstraints = false
        registerPassword.isSecureTextEntry = true
        registerPassword.autocorrectionType = .no
        registerPassword.autocapitalizationType = .none
        view.addSubview(registerPassword)
        
        nextButton = UIButton()
        nextButton.layer.cornerRadius = 20
        nextButton.layer.masksToBounds = false
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = pink.cgColor
        nextButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        nextButton.layer.shadowOpacity = 1
        nextButton.layer.shadowRadius = 4
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        nextButton.setTitle("Create Account", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = pink
        nextButton.isUserInteractionEnabled = true
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        
    }
    
    func setupConstraints() {
        
        let height: CGFloat = view.frame.height
        let width: CGFloat = view.frame.width
        let padding: CGFloat = width/15
        
        NSLayoutConstraint.activate([
            startLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            startLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: height*0.05)
        ])
        
        NSLayoutConstraint.activate([
            registerFName.leadingAnchor.constraint(equalTo: startLabel.leadingAnchor),
            registerFName.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: height*0.04),
            registerFName.widthAnchor.constraint(equalToConstant: width/3),
            registerFName.heightAnchor.constraint(equalToConstant: height*0.03)
        ])
        
        NSLayoutConstraint.activate([
            registerLName.topAnchor.constraint(equalTo: registerFName.topAnchor),
            registerLName.heightAnchor.constraint(equalTo: registerFName.heightAnchor),
            registerLName.widthAnchor.constraint(equalTo: registerFName.widthAnchor),
            registerLName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            registerEmail.leadingAnchor.constraint(equalTo: startLabel.leadingAnchor),
            registerEmail.trailingAnchor.constraint(equalTo: registerLName.trailingAnchor),
            registerEmail.heightAnchor.constraint(equalTo: registerFName.heightAnchor),
            registerEmail.topAnchor.constraint(equalTo: registerFName.bottomAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            registerPassword.leadingAnchor.constraint(equalTo: startLabel.leadingAnchor),
            registerPassword.trailingAnchor.constraint(equalTo: registerLName.trailingAnchor),
            registerPassword.heightAnchor.constraint(equalTo: registerFName.heightAnchor),
            registerPassword.topAnchor.constraint(equalTo: registerEmail.bottomAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: width*0.88),
            nextButton.heightAnchor.constraint(equalToConstant: height*0.0625),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -height*0.03)
        ])
    }
    
    @objc func nextButtonTapped() {
        
        var canRegister = true
        
        var userInputEmail = ""
        if let email = registerEmail.text{
            userInputEmail = email
        }
        if (userInputEmail == "") {
            let alert = UIAlertController(title: "Alert", message: "Please provide an email address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            canRegister = false
        }
        
        var userInputFName = ""
        if let firstName = registerFName.text{
            userInputFName = firstName
        }
        if (userInputFName == "") {
            let alert = UIAlertController(title: "Alert", message: "Please provide a first name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            canRegister = false
        }
        
        var userInputLName = ""
        if let lastName = registerLName.text{
            userInputLName = lastName
        }
        if (userInputLName == "") {
            let alert = UIAlertController(title: "Alert", message: "Please provide a last name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            canRegister = false
        }
        
        var userInputPassword = ""
        if let password = registerPassword.text{
            userInputPassword  = password
        }
        if (userInputPassword == "") {
            let alert = UIAlertController(title: "Alert", message: "Please set a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            canRegister = false
        }
        
        
        let email = userInputEmail
        let name = userInputFName + " " + userInputLName
        let password = userInputPassword
        
        if canRegister {
            NetworkManager.registerUser(email: email, name: name, password: password, completion: { (accountDetails) in
                LoginViewController.currentUser = User(session_token: accountDetails.session_token, session_expiration: accountDetails.session_expiration, update_token: accountDetails.update_token, userId: accountDetails.id)
            }) { (errorMessage) in
                self.createAlert(message: errorMessage)
            }
        }
    }
    
    func createAlert(message: String) {
        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

}
