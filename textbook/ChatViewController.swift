//
//  ChatViewController.swift
//  
//
//  Created by Jessica Wu on 12/30/20.
//

import UIKit
import MessageKit

class ChatViewController: MessagesViewController {
    
    let currentUser = Sender(senderId: "self", displayName: "Me")
    let otherUser = Sender(senderId: "other", displayName: "Other")
    var messages: [MessageType] = []
    
    struct Sender: SenderType {
        var senderId: String
        var displayName: String
    }
    
    struct Message: MessageType {
        var sender: SenderType
        var messageId: String
        var sentDate: Date
        var kind: MessageKind
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        //TODO: fake data, remove later
        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-7000), kind: .text("Hi there!")))
        messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-6000), kind: .text("Hi! How are you doing?")))
        messages.append(Message(sender: currentUser, messageId: "3", sentDate: Date().addingTimeInterval(-5000), kind: .text("I'm doing great! How about you?")))
        messages.append(Message(sender: otherUser, messageId: "4", sentDate: Date().addingTimeInterval(-4000), kind: .text("I'm doing great as well, when would you like to meet up?")))
        messages.append(Message(sender: currentUser, messageId: "5", sentDate: Date().addingTimeInterval(-3000), kind: .text("Are you free later today afternoon? Are you free later today afternoon? Are you free later today afternoon? Are you free later today afternoon? Are you free later today afternoon?")))
    
        setupConstraints()
    }
    
    func setupConstraints() {
        let padding: CGFloat = view.frame.width*0.02
        NSLayoutConstraint.activate([
            messagesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            messagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            messagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            messagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    
}

extension ChatViewController: MessagesLayoutDelegate {
    
}
