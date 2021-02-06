//
//  TabBarController.swift
//  textbook
//
//  Created by Zuhao Hua on 11/29/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation

import UIKit

class TabBarController: UITabBarController {
    
    // hide the navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarItem.appearance()
        let attributes: [NSAttributedString.Key: AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont(name: "American Typewriter", size: 12)!]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        //homescreen
        let home = generateNavController(vc: HomeScreenController(), barTitle: "Home", pageTitle: "Home", image: UIImage(systemName: "house")!)
        
        //sell new book
        let addNewBook = generateNavController(vc: AddNewBook(), barTitle: "Sell", pageTitle: "Sell A New Book", image: UIImage(systemName: "plus.circle")!)
        
        //cart
        let cart = generateNavController(vc: SavedViewController(), barTitle: "Saved", pageTitle: "Saved", image: UIImage(systemName: "bookmark")!)
        
        //default profile
        let profile = generateNavController(vc: ProfileViewController(), barTitle: "Profile", pageTitle: "", image: UIImage(systemName: "person.fill")!)
        
        //chat
        let chat = generateNavController(vc: ChatManagerViewController(), barTitle: "Chat", pageTitle: "Chats", image: UIImage(systemName: "envelope")!)
        
        viewControllers = [home,chat,addNewBook,cart,profile]
        
    }
    
    func generateNavController(vc:UIViewController,barTitle:String,pageTitle: String,image:UIImage)->UINavigationController{
        vc.navigationItem.title = pageTitle
        //vc.view.backgroundColor = .white
        let navController = UINavigationController(rootViewController: vc)
        navController.title = barTitle
        navController.tabBarItem.image = image
        
        return navController
    }
    
}
