//
//  ChatManagerViewController.swift
//  textbook
//
//  Created by Jessica Wu on 12/30/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class ChatManagerViewController: UIViewController {
    
    var chatListTableView: UITableView!
    var chats: [String] = []
    let chatManagerCellReuseIdentifier = "chatManagerCellReuseIdentifier"
    var tableViewHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //TODO: fake data, remove the fake data later; DO NOT remove array, array should hold list of users that the current user has chats with. For now array takes Strings only because it is easier for me to input fake data, later on change the chats array type AND the configure function in ChatManagerTableViewCell.swift
        chats = ["Amy","Thomas","Joey"]
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
        chatListTableView = UITableView()
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        chatListTableView.register(ChatManagerTableViewCell.self, forCellReuseIdentifier: chatManagerCellReuseIdentifier)
        chatListTableView.translatesAutoresizingMaskIntoConstraints = false
        //chatListTableView.separatorStyle = .none
        view.addSubview(chatListTableView)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            chatListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ChatManagerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatManagerCellReuseIdentifier, for: indexPath) as! ChatManagerTableViewCell
        //TODO: will need to change once configure is changed
        cell.configure(name: chats[indexPath.item])
        return cell
    }
}

extension ChatManagerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableViewHeight = view.frame.height/14
        return tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let newViewController = ChatViewController()
//        //TODO: set title name to the other user's name
//        newViewController.title = chats[indexPath.item]
//        navigationController?.pushViewController(newViewController, animated: true)
    }
}
