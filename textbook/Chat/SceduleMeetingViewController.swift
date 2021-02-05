//
//  SceduleMeetingViewController.swift
//  textbook
//
//  Created by Jessica Wu on 2/4/21.
//  Copyright © 2021 Anya Ji. All rights reserved.
//

import UIKit

class SceduleMeetingViewController: UIViewController {
    
    let gray: UIColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1)
    let pink: UIColor = UIColor(red: 1, green: 0.479, blue: 0.479, alpha: 1)
    
    var backgroundView: UIView!
    var bookTitle: UITextField!
    var bookPrice: UITextField!
    var whenLabel: UILabel!
    var whenTextField: UITextField!
    var whereLabel: UILabel!
    var paymentLabel: UILabel!
    var paymentTextfield: UITextField!
    var createButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.88, height: view.frame.height*0.63))
        backgroundView.center = view.center
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 7
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.white.cgColor
        backgroundView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        backgroundView.layer.shadowOpacity = 1
        backgroundView.layer.shadowRadius = 4
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.addSubview(backgroundView)
        
        bookTitle = UITextField()
        let bookTitlePlaceHolder=NSAttributedString(string: "Book Name", attributes:[NSAttributedString.Key.foregroundColor :UIColor.darkGray])
        bookTitle.textColor = gray
        bookTitle.attributedPlaceholder = bookTitlePlaceHolder
        bookTitle.layer.backgroundColor = UIColor.white.cgColor
        bookTitle.layer.borderColor = gray.cgColor
        bookTitle.layer.borderWidth = 0.0
        bookTitle.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        bookTitle.layer.shadowOpacity = 1.0
        bookTitle.layer.shadowRadius = 0.0
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        bookTitle.autocorrectionType = .no
        view.addSubview(bookTitle)
        
        bookPrice = UITextField()
        let bookPricePlaceHolder=NSAttributedString(string: "Price", attributes:[NSAttributedString.Key.foregroundColor :UIColor.darkGray])
        bookPrice.textColor = gray
        bookPrice.attributedPlaceholder = bookPricePlaceHolder
        bookPrice.layer.backgroundColor = UIColor.white.cgColor
        bookPrice.layer.borderColor = gray.cgColor
        bookPrice.layer.borderWidth = 0.0
        bookPrice.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        bookPrice.layer.shadowOpacity = 1.0
        bookPrice.layer.shadowRadius = 0.0
        bookPrice.translatesAutoresizingMaskIntoConstraints = false
        bookPrice.autocorrectionType = .no
        view.addSubview(bookPrice)
        
        whenLabel = UILabel()
        whenLabel.text = "When"
        whenLabel.textColor = .black
        whenLabel.font = UIFont.boldSystemFont(ofSize: 20)
        whenLabel.isUserInteractionEnabled = false
        whenLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(whenLabel)
        
        // whenPicker
        
        whereLabel = UILabel()
        whereLabel.text = "Where"
        whereLabel.textColor = .black
        whereLabel.font = UIFont.boldSystemFont(ofSize: 20)
        whereLabel.isUserInteractionEnabled = false
        whereLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(whereLabel)
        
        // wherePicker
        
        whereLabel = UILabel()
        whereLabel.text = "Where"
        whereLabel.textColor = .black
        whereLabel.font = UIFont.boldSystemFont(ofSize: 20)
        whereLabel.isUserInteractionEnabled = false
        whereLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(whereLabel)
        
        paymentLabel = UILabel()
        paymentLabel.text = "Payment Method"
        paymentLabel.textColor = .black
        paymentLabel.font = UIFont.boldSystemFont(ofSize: 20)
        paymentLabel.isUserInteractionEnabled = false
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentLabel)
        
        createButton = UIButton()
        createButton.layer.cornerRadius = 20
        createButton.layer.masksToBounds = false
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = pink.cgColor
        createButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        createButton.layer.shadowOpacity = 1
        createButton.layer.shadowRadius = 4
        createButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        createButton.setTitle("Create Meeting", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.backgroundColor = pink
        createButton.isUserInteractionEnabled = true
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createButton)
        
    }
    
    func setupConstraints() {
        
        let height: CGFloat = view.frame.height
        let width: CGFloat = view.frame.width
        let padding: CGFloat = width/10
        
        NSLayoutConstraint.activate([
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.widthAnchor.constraint(equalToConstant: width*0.88),
            createButton.heightAnchor.constraint(equalToConstant: height*0.0625),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -height*0.03)
        ])
    }
    
    @objc func createButtonTapped() {
        // TODO
    }

}
