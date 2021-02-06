//
//  SavedViewController.swift
//  textbook
//
//  Created by Vicki Yang on 2/4/21.
//  Copyright © 2021 Anya Ji. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {

    let pink: UIColor = UIColor(red: 1, green: 0.479, blue: 0.479, alpha: 1)
    
    var savedTableView: UITableView!
    var savedTotalLabelLeft: LeftLabel!
    var savedTotalLabelRight: RightLabel!
    var blackLine: UILabel!
    var confirmButton: UIButton!
    let sidePadding:CGFloat = 25
    
    //var totalValue:Double = 0
    
    var booksInSaved: [Book] = []
    
    var cartFromBackend : [Book] = []
    var retrievedUserInfo: userInfoResponseDataStruct!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        //Initialize tableView
        savedTableView = UITableView()
        savedTableView.translatesAutoresizingMaskIntoConstraints = false
        savedTableView.dataSource = self
        savedTableView.delegate = self
        savedTableView.register(SavedTableViewCell.self, forCellReuseIdentifier: SavedTableViewCell.savedTableViewCellIdentifier)
        savedTableView.backgroundColor = .white
        savedTableView.layer.cornerRadius = 20
        savedTableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        savedTableView.clipsToBounds = true
        savedTableView.showsVerticalScrollIndicator = false
        savedTableView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        savedTableView.bounces = false
        savedTableView.separatorStyle = .none
        view.addSubview(savedTableView)
        
//        blackLine = UILabel()
//        blackLine.translatesAutoresizingMaskIntoConstraints = false
//        blackLine.backgroundColor = .black
//        blackLine.isUserInteractionEnabled = false
//        view.addSubview(blackLine)
        
//        savedTotalLabelLeft = LeftLabel()
//        savedTotalLabelLeft.translatesAutoresizingMaskIntoConstraints = false
//        savedTotalLabelLeft.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//        savedTotalLabelLeft.layer.cornerRadius = 20
//        savedTotalLabelLeft.layer.maskedCorners = [.layerMinXMaxYCorner]
//        savedTotalLabelLeft.clipsToBounds = true
//        savedTotalLabelLeft.text = "Total"
//        savedTotalLabelLeft.isUserInteractionEnabled = false
//        savedTotalLabelLeft.font = .systemFont(ofSize: 20)
//        view.addSubview(savedTotalLabelLeft)
        
//        savedTotalLabelRight = RightLabel()
//        savedTotalLabelRight.translatesAutoresizingMaskIntoConstraints = false
//        savedTotalLabelRight.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//        savedTotalLabelRight.layer.cornerRadius = 20
//        savedTotalLabelRight.layer.maskedCorners = [.layerMaxXMaxYCorner]
//        savedTotalLabelRight.clipsToBounds = true
//        savedTotalLabelRight.text = "$ 0"
//        savedTotalLabelRight.textAlignment = .right
//        savedTotalLabelRight.isUserInteractionEnabled = false
//        savedTotalLabelRight.font = .systemFont(ofSize: 20)
//        view.addSubview(savedTotalLabelRight)
        
//        confirmButton = UIButton()
//        confirmButton.layer.cornerRadius = 20
//        confirmButton.clipsToBounds = true
//        confirmButton.setTitle("Confirm Purchase", for: .normal)
//        //confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        confirmButton.setTitleColor(.white, for: .normal)
//        confirmButton.translatesAutoresizingMaskIntoConstraints = false
//        confirmButton.backgroundColor = pink
//        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
//        view.addSubview(confirmButton)
        
        //retrieveUserCart()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool){
        retrieveUserCart()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            savedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: sidePadding),
            savedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -sidePadding),
            savedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            savedTableView.heightAnchor.constraint(equalToConstant: view.frame.height*0.5)
        ])
        
//        NSLayoutConstraint.activate([
//            blackLine.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: sidePadding),
//            blackLine.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -sidePadding),
//            blackLine.topAnchor.constraint(equalTo: savedTableView.bottomAnchor),
//            blackLine.heightAnchor.constraint(equalToConstant: 1)
//        ])
        
//        NSLayoutConstraint.activate([
//            savedTotalLabelLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: sidePadding),
//            savedTotalLabelLeft.topAnchor.constraint(equalTo: blackLine.bottomAnchor),
//            savedTotalLabelLeft.heightAnchor.constraint(equalToConstant: 50),
//            savedTotalLabelLeft.widthAnchor.constraint(equalToConstant: (view.frame.width-sidePadding*2)/2)
//        ])
        
//        NSLayoutConstraint.activate([
//            savedTotalLabelRight.leadingAnchor.constraint(equalTo: cartTotalLabelLeft.trailingAnchor),
//            savedTotalLabelRight.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -sidePadding),
//            savedTotalLabelRight.topAnchor.constraint(equalTo: blackLine.bottomAnchor),
//            savedTotalLabelRight.heightAnchor.constraint(equalToConstant: 50)
//        ])
        
//        NSLayoutConstraint.activate([
//            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
//            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
//            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
//            confirmButton.heightAnchor.constraint(equalToConstant: 40)
//        ])
        
    }
    
    private func retrieveUserCart(){ // need to update backend stuff
        
        let sellerID :Int = NewLoginViewController.currentUser.id //this is correct now
        
        var cartFromBackend : [Book] = []
        self.booksInSaved = []
        //self.totalValue = 0
        //self.cartTotalLabelRight.text = String(format: "%.2f", self.totalValue)
        
        self.savedTableView.reloadData()
        
        NetworkManager.getUserCart(currentUserId: sellerID){ books in
            cartFromBackend = books
            for item in cartFromBackend{
                let newItem = item
                self.booksInSaved.append(newItem)
                //self.totalValue += Double(newItem.price)!
                //self.cartTotalLabelRight.text = String(format: "%.2f", self.totalValue)
                
            }
            
            //reload
            DispatchQueue.main.async {
                self.savedTableView.reloadData()
            }
        }
        
        
    }
    
    private func updateCartAfterDelete(deletedBookID:Int){
        
        let books = booksInSaved
        booksInSaved = []
        for b in books{
            if b.id != deletedBookID{
                booksInSaved.append(b)
            }
            else{
                //self.totalValue -= Double(b.price)!
                //self.cartTotalLabelRight.text = String(format: "%.2f", self.totalValue)
            }
        }
 
        //reload
        DispatchQueue.main.async {
            self.savedTableView.reloadData()
        }

    }
    
    
//    @objc func confirmButtonTapped(){
//        let newViewController = SuccessViewController()
//        navigationController?.pushViewController(newViewController, animated: true)
//    }
    
   
}

extension SavedViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Items"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return currentCart.count
        return booksInSaved.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedTableViewCell.savedTableViewCellIdentifier, for: indexPath) as! SavedTableViewCell
        //let oneBook = currentCart[indexPath.row]
        let oneBook = booksInSaved[indexPath.row]
        cell.configure(inputbookData: oneBook)
        cell.delegate = self
        return cell
    }
    
    
}

extension SavedViewController:UITableViewDelegate{
    
}

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension SavedViewController:deleteFromCart{
    
    func deleteFromCartAction(bookId: Int) {
        
        let sellerID :Int = LoginViewController.currentUser.id
        let updateToken:String = LoginViewController.currentUser.update_token
        
        //call network manager to delete the book
        NetworkManager.deleteOneBookFromCart(currentUserId: sellerID, bookId: bookId,updateToken: updateToken){ books in //returned cart is not used
            //call retrieve user cart to update cart information
            self.updateCartAfterDelete(deletedBookID: bookId)
        }
        
        
        
        
    }

}
