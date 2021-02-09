//
//  NewLoginViewController.swift
//  textbook
//
//  Created by Jessica Wu on 2/3/21.
//  Copyright © 2021 Anya Ji. All rights reserved.
//

import UIKit

class NewLoginViewController: UIViewController {
    
    let gray: UIColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1)
    let aqua: UIColor = UIColor(red: 0.168, green: 0.543, blue: 0.567, alpha: 1)
    let pink: UIColor = UIColor(red: 1, green: 0.479, blue: 0.479, alpha: 1)
    
    var loginLabel: UILabel!
    var loginEmail: UITextField!
    var loginPassword: UITextField!
    var loginButton: UIButton!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = false
        
        setupToHideKeyboardOnTapOnView()
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
        loginLabel = UILabel()
        loginLabel.text = "Welcome Back"
        loginLabel.textColor = aqua
        loginLabel.font = UIFont.boldSystemFont(ofSize: 28)
        loginLabel.isUserInteractionEnabled = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        
        loginEmail = UITextField()
        let loginEmailPlaceHolder=NSAttributedString(string: "Student Email", attributes:[NSAttributedString.Key.foregroundColor :UIColor.darkGray])
        loginEmail.textColor = gray
        loginEmail.attributedPlaceholder = loginEmailPlaceHolder
        loginEmail.layer.backgroundColor = UIColor.white.cgColor
        loginEmail.layer.borderColor = gray.cgColor
        loginEmail.layer.borderWidth = 0.0
        loginEmail.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        loginEmail.layer.shadowOpacity = 1.0
        loginEmail.layer.shadowRadius = 0.0
        loginEmail.translatesAutoresizingMaskIntoConstraints = false
        loginEmail.autocorrectionType = .no
        loginEmail.autocapitalizationType = .none
        view.addSubview(loginEmail)
        
        loginPassword = UITextField()
        let loginPasswordPlaceHolder=NSAttributedString(string: "Password", attributes:[NSAttributedString.Key.foregroundColor :UIColor.darkGray])
        loginPassword.textColor = gray
        loginPassword.attributedPlaceholder = loginPasswordPlaceHolder
        loginPassword.layer.backgroundColor = UIColor.white.cgColor
        loginPassword.layer.borderColor = gray.cgColor
        loginPassword.layer.borderWidth = 0.0
        loginPassword.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        loginPassword.layer.shadowOpacity = 1.0
        loginPassword.layer.shadowRadius = 0.0
        loginPassword.translatesAutoresizingMaskIntoConstraints = false
        loginPassword.autocorrectionType = .no
        loginPassword.autocapitalizationType = .none
        loginPassword.isSecureTextEntry = true
        view.addSubview(loginPassword)
        
        loginButton = UIButton()
        loginButton.layer.cornerRadius = 20
        loginButton.layer.masksToBounds = false
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = pink.cgColor
        loginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.shadowRadius = 4
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = pink
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
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: height*0.05)
        ])
        
        NSLayoutConstraint.activate([
            loginEmail.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            loginEmail.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: height*0.04),
            loginEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            loginEmail.heightAnchor.constraint(equalToConstant: height*0.03)
        ])
        
        NSLayoutConstraint.activate([
            loginPassword.leadingAnchor.constraint(equalTo: loginEmail.leadingAnchor),
            loginPassword.trailingAnchor.constraint(equalTo: loginEmail.trailingAnchor),
            loginPassword.heightAnchor.constraint(equalTo: loginEmail.heightAnchor),
            loginPassword.topAnchor.constraint(equalTo: loginEmail.bottomAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: width*0.88),
            loginButton.heightAnchor.constraint(equalToConstant: height*0.0625),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -height*0.03)
        ])
    }
    
    @objc func loginButtonTapped() {
        
        var canLogIn = true
        
        var userInputEmail = ""
        if let email = loginEmail.text{
            userInputEmail = email
        }
        if (userInputEmail == "") {
            let alert = UIAlertController(title: "Alert", message: "Please provide an email address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            canLogIn = false
        }
        
        var userInputPassword = ""
        if let password = loginPassword.text{
            userInputPassword  = password
        }
        if (userInputPassword == "") {
            let alert = UIAlertController(title: "Alert", message: "Please enter your password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            canLogIn = false
        }
        
        let email = userInputEmail
        let password = userInputPassword
        
        if canLogIn {
            NetworkManager.loginUser(email: email, password: password, completion: { (accountDetails) in
                NetworkManager.currentUser = User(session_token: accountDetails.session_token, session_expiration: accountDetails.session_expiration, update_token: accountDetails.update_token, userId: accountDetails.id)
                
                //save user
                let user = try? PropertyListEncoder().encode(NetworkManager.currentUser)
                self.userDefaults.set(user, forKey: "currentUser")
                
                NetworkManager.getUserInfo(currentUserId: accountDetails.id) { (userInfo) in
                    NetworkManager.currentUserInfo = UserInfo(id: accountDetails.id, email: email, name: userInfo.name)
                    
                    //save userInfo
                    let userInfo = try? PropertyListEncoder().encode(NetworkManager.currentUserInfo)
                    self.userDefaults.set(userInfo, forKey: "currentUserInfo")
                    
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                }
                
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
    
    //they are used when we want to dismiss the keyboard when tap outside of UITextField
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
