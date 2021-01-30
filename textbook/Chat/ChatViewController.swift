//
//  ChatViewController.swift
//  
//
//  Created by Jessica Wu on 12/30/20.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {
    
    var currentUser: Sender!
    var otherUser: Sender!
    var messages: [MessageType] = []
    var book: Book!
    
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
    
    init(currentUser: UserInfo, otherUser: UserInfo, book: Book){
        super.init(nibName: nil, bundle: nil)
        self.currentUser = Sender(senderId: currentUser.email, displayName: currentUser.name)
        self.otherUser = Sender(senderId: otherUser.email, displayName: otherUser.name)
        self.book = book
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        self.title = otherUser.displayName
        
        //TODO: fake data, remove later
        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-7000), kind: .text("Hi there!")))
        messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-6000), kind: .text("Hi! How are you doing?")))
        messages.append(Message(sender: currentUser, messageId: "3", sentDate: Date().addingTimeInterval(-5000), kind: .text("I'm doing great! How about you?")))
        messages.append(Message(sender: otherUser, messageId: "4", sentDate: Date().addingTimeInterval(-4000), kind: .text("I'm doing great as well, when would you like to meet up?")))
        messages.append(Message(sender: currentUser, messageId: "5", sentDate: Date().addingTimeInterval(-3000), kind: .text("Are you free later today afternoon? Are you free later today afternoon? Are you free later today afternoon? Are you free later today afternoon? Are you free later today afternoon?")))
        
        configureMessageInputBar()
        
        setupConstraints()
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        //        messageInputBar.inputTextView.tintColor = .primaryColor
        //        messageInputBar.sendButton.setTitleColor(.primaryColor, for: .normal)
        //        messageInputBar.sendButton.setTitleColor(
        //            UIColor.primaryColor.withAlphaComponent(0.3),
        //            for: .highlighted
        //        )
        //        configureInputBarItems()
        
        let items = [
            makeButton()
            
        ]
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.setStackViewItems(items, forStack: .left, animated: false)
        
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

// MARK: - MessageInputBarDelegate

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    @objc
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        processInputBar(messageInputBar)
    }
    
    func makeButton() -> InputBarButtonItem {
        let button = InputBarButtonItem()
        
        button.setSize(CGSize(width: 36, height: 36), animated: false)
        button.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .systemBlue
        
        button.onTouchUpInside {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(action)
            if let popoverPresentationController = actionSheet.popoverPresentationController {
                popoverPresentationController.sourceView = $0
                popoverPresentationController.sourceRect = $0.frame
            }
            self.navigationController?.present(actionSheet, animated: true, completion: nil)
        }
        
        return button
        
        
        //        return InputBarButtonItem()
        //            .configure {
        //                $0.spacing = .fixed(10)
        //                $0.image = UIImage(systemName: named)?.withRenderingMode(.alwaysTemplate)
        //                //                $0.setSize(CGSize(width: 25, height: 25), animated: false)
        //                $0.tintColor = .systemBlue
        //                //            }.onSelected {
        //                //                $0.tintColor = .blue
        //                //            }.onDeselected {
        //                //                $0.tintColor = .blue
        //        }.onTouchUpInside {
        //            print("Item Tapped")
        //            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //            actionSheet.addAction(action)
        //            if let popoverPresentationController = actionSheet.popoverPresentationController {
        //                popoverPresentationController.sourceView = $0
        //                popoverPresentationController.sourceRect = $0.frame
        //            }
        //            self.navigationController?.present(actionSheet, animated: true, completion: nil)
        //        }
    }
    
    func processInputBar(_ inputBar: InputBarAccessoryView) {
        
        inputBar.inputTextView.text = String()
        let components = inputBar.inputTextView.components
        
        inputBar.invalidatePlugins()
        // Send button activity animation
        inputBar.sendButton.startAnimating()
        inputBar.inputTextView.placeholder = "Sending..."
        // Resign first responder for iPad split view
        inputBar.inputTextView.resignFirstResponder()
        DispatchQueue.global(qos: .default).async {
            // fake send request task
            sleep(1)
            DispatchQueue.main.async { [weak self] in
                inputBar.sendButton.stopAnimating()
                inputBar.inputTextView.placeholder = "Aa"
                self?.insertMessages(components)
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        }
    }
    
    private func insertMessages(_ data: [Any]) {
        //        for component in data {
        //            let user = SampleData.shared.currentSender
        //            if let str = component as? String {
        //                let message = MockMessage(text: str, user: user, messageId: UUID().uuidString, date: Date())
        //                insertMessage(message)
        //            } else if let img = component as? UIImage {
        //                let message = MockMessage(image: img, user: user, messageId: UUID().uuidString, date: Date())
        //                insertMessage(message)
        //            }
        //        }
    }
}

