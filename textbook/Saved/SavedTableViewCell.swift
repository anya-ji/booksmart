//
//  SavedTableViewCell.swift
//  textbook
//
//  Created by Vicki Yang on 2/5/21.
//  Copyright © 2021 Anya Ji. All rights reserved.
//

import UIKit

protocol deleteFromCart:class {
    func deleteFromCartAction(bookId:Int)
}

class SavedTableViewCell: UITableViewCell {

    var textBookId: Int!
    var textbookImage: UIImageView!
    var textbookTitle: UILabel!
    var textbookPriceLabel: UILabel!
    var deleteButton : UIButton!
    weak var delegate:deleteFromCart?
    
    let sidePadding:CGFloat = 20
    
    static let savedTableViewCellIdentifier = "savedTableViewCellIdentifier"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //the line below is for creating space between cells in UITableView
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        selectionStyle = .none
        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        textbookImage = UIImageView()
        textbookImage.translatesAutoresizingMaskIntoConstraints = false
        textbookImage.contentMode = .scaleToFill
        textbookImage.layer.cornerRadius = 20
        textbookImage.clipsToBounds = true
        contentView.addSubview(textbookImage)
        
        textbookTitle = UILabel()
        textbookTitle.translatesAutoresizingMaskIntoConstraints = false
        textbookTitle.font = .systemFont(ofSize: 18)
        textbookTitle.textColor = .black
        contentView.addSubview(textbookTitle)
        
        textbookPriceLabel = UILabel()
        textbookPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        textbookPriceLabel.font = .systemFont(ofSize: 18)
        textbookPriceLabel.textColor = .black
        contentView.addSubview(textbookPriceLabel)
        
        //delete button
//        deleteButton = UIImageView()
//        deleteButton.image = UIImage(systemName: "xmark")
//        deleteButton.translatesAutoresizingMaskIntoConstraints = false
//        deleteButton.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//        contentView.addSubview(deleteButton)
//        let tapDeleteGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappingDelete(recognizer:)))
//        tapDeleteGesture.numberOfTapsRequired = 1
//        deleteButton.addGestureRecognizer(tapDeleteGesture)
        
        deleteButton = UIButton()
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        deleteButton.addTarget(self, action: #selector(tappingDelete), for: .touchUpInside)
        contentView.addSubview(deleteButton)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            textbookImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            textbookImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textbookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: sidePadding),
            textbookImage.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.4)
        ])
        
        NSLayoutConstraint.activate([
            textbookTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            textbookTitle.leadingAnchor.constraint(equalTo: textbookImage.trailingAnchor, constant: contentView.frame.width*0.05),
            textbookTitle.heightAnchor.constraint(equalToConstant: 50),
            textbookTitle.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.4)
        ])
        
        NSLayoutConstraint.activate([
            textbookPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textbookPriceLabel.heightAnchor.constraint(equalToConstant: 50),
            textbookPriceLabel.leadingAnchor.constraint(equalTo: textbookImage.trailingAnchor, constant: contentView.frame.width*0.05),
            textbookPriceLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.4)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            deleteButton.heightAnchor.constraint(equalToConstant: 20),
            deleteButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    
    func configure(inputbookData:Book){
        
        if inputbookData.image.count == 0 {
            textbookImage.image = UIImage(named: "default_book")
        }
        else{
            textbookImage.sd_setImage(with: URL(string: inputbookData.image[0].url), placeholderImage: UIImage(named: "default_book"))

        }
        
        
        textBookId = inputbookData.id
        textbookTitle.text = inputbookData.title
        textbookPriceLabel.text = inputbookData.price
        
    }
    
    
    @objc func tappingDelete(){
        //delete button tapped
        delegate?.deleteFromCartAction(bookId: textBookId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
