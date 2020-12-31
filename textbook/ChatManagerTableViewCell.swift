//
//  ChatManagerTableViewCell.swift
//  textbook
//
//  Created by Jessica Wu on 12/30/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class ChatManagerTableViewCell: UITableViewCell {
    
    var chatName: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        // add additional things later, need Ryun to come up with design first
        
        chatName = UILabel()
        chatName.textColor = .black
        chatName.font = .boldSystemFont(ofSize: 23)
        chatName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chatName)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            chatName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chatName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding)
        ])
    }
    
    // TODO: configure function should take in the user id (or something else) and set the chatName text to the user's name; for now it will just take in the user name as a String directly
    func configure(name: String) {
        chatName.text = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
