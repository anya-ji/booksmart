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
    let lightGray: UIColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
    
    var backgroundView: UIView!
    var bookTitle: UITextField!
    var bookPrice: UITextField!
    var whenLabel: UILabel!
    var dateTextField: UITextField!
    var hourTextField: UITextField!
    var whereLabel: UILabel!
    var wherePicker: UIPickerView!
    var otherTextField: UITextField!
    var paymentLabel: UILabel!
    var paymentTextfield: UITextField!
    var createButton: UIButton!
    var locations:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add in locations here later
        locations = ["place 1", "place 2", "place 3", "place 4", "place 5", "other"]

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
        
        dateTextField = UITextField()
        dateTextField.textAlignment = .center
        let dateTextFieldPlaceHolder=NSAttributedString(string: "(MM/YY)", attributes:[NSAttributedString.Key.foregroundColor :UIColor.black])
        dateTextField.textColor = UIColor.black
        dateTextField.attributedPlaceholder = dateTextFieldPlaceHolder
        dateTextField.layer.backgroundColor = lightGray.cgColor
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.autocorrectionType = .no
        view.addSubview(dateTextField)
                
        hourTextField = UITextField()
        hourTextField.textAlignment = .center
        let hourTextFieldPlaceHolder=NSAttributedString(string: "(HH:MM am/pm)", attributes:[NSAttributedString.Key.foregroundColor :UIColor.black])
        hourTextField.textColor = UIColor.black
        hourTextField.attributedPlaceholder = hourTextFieldPlaceHolder
        hourTextField.layer.backgroundColor = lightGray.cgColor
        hourTextField.translatesAutoresizingMaskIntoConstraints = false
        hourTextField.autocorrectionType = .no
        view.addSubview(hourTextField)
                
        whereLabel = UILabel()
        whereLabel.text = "Where"
        whereLabel.textColor = .black
        whereLabel.font = UIFont.boldSystemFont(ofSize: 20)
        whereLabel.isUserInteractionEnabled = false
        whereLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(whereLabel)
                
        wherePicker = UIPickerView()
        wherePicker.translatesAutoresizingMaskIntoConstraints = false
        wherePicker.delegate = self
        wherePicker.dataSource = self
        view.addSubview(wherePicker)
        
        otherTextField = UITextField()
        let otherTextFieldPlaceHolder=NSAttributedString(string: "Enter Other Location Here", attributes:[NSAttributedString.Key.foregroundColor :UIColor.darkGray])
        otherTextField.textColor = gray
        otherTextField.attributedPlaceholder = otherTextFieldPlaceHolder
        otherTextField.layer.backgroundColor = UIColor.white.cgColor
        otherTextField.layer.borderColor = gray.cgColor
        otherTextField.layer.borderWidth = 0.0
        otherTextField.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        otherTextField.layer.shadowOpacity = 1.0
        otherTextField.layer.shadowRadius = 0.0
        otherTextField.isHidden = true
        otherTextField.isUserInteractionEnabled = false
        otherTextField.translatesAutoresizingMaskIntoConstraints = false
        otherTextField.autocorrectionType = .no
        view.addSubview(otherTextField)
                
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
        
        let width: CGFloat = view.frame.width
        let height: CGFloat = view.frame.height
        let padding: CGFloat = view.frame.width*0.06
        
        NSLayoutConstraint.activate([
            bookTitle.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: padding),
            bookTitle.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -padding),
            bookTitle.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: padding)
        ])
                
        NSLayoutConstraint.activate([
            bookPrice.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            bookPrice.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            bookPrice.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: padding*1.5)
        ])
                
        NSLayoutConstraint.activate([
            whenLabel.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            whenLabel.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor),
            whenLabel.topAnchor.constraint(equalTo: bookPrice.bottomAnchor, constant: padding*1.25)
        ])
        
        NSLayoutConstraint.activate([
            dateTextField.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            dateTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -padding/2),
            dateTextField.topAnchor.constraint(equalTo: whenLabel.bottomAnchor, constant: padding/4),
            dateTextField.heightAnchor.constraint(equalToConstant: height*0.05)
        ])
                
        NSLayoutConstraint.activate([
            hourTextField.leadingAnchor.constraint(equalTo: backgroundView.centerXAnchor, constant: padding/2),
            hourTextField.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor),
            hourTextField.topAnchor.constraint(equalTo: dateTextField.topAnchor),
            hourTextField.heightAnchor.constraint(equalTo: dateTextField.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            whereLabel.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            whereLabel.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor),
            whereLabel.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: padding*1.25)
        ])
        
        NSLayoutConstraint.activate([
            wherePicker.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            wherePicker.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor),
            wherePicker.bottomAnchor.constraint(equalTo: whereLabel.bottomAnchor, constant: height*0.15)
        ])
        
        NSLayoutConstraint.activate([
            otherTextField.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            otherTextField.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor),
            otherTextField.bottomAnchor.constraint(equalTo: paymentLabel.topAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            paymentLabel.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            paymentLabel.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor),
            paymentLabel.topAnchor.constraint(equalTo: wherePicker.bottomAnchor, constant: padding/8)
        ])
        
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

extension SceduleMeetingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
}

extension SceduleMeetingViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == locations.count - 1 {
            otherTextField.isHidden = false
            otherTextField.isUserInteractionEnabled = true
        } else {
            otherTextField.isHidden = true
            otherTextField.isUserInteractionEnabled = false
        }
    }
    
}
