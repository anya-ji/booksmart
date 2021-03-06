//
//  CartViewController.swift
//  textbook
//
//  Created by Zuhao Hua on 12/3/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//
import UIKit

class CartViewController: UIViewController {
    
//    let pink: UIColor = UIColor(red: 1, green: 0.479, blue: 0.479, alpha: 1)
//    
//    var cartTableView: UITableView!
//    var cartTotalLabelLeft: LeftLabel!
//    var cartTotalLabelRight: RightLabel!
//    var blackLine: UILabel!
//    var confirmButton: UIButton!
//    let sidePadding:CGFloat = 25
//    
//    var totalValue:Double = 0
//    
//    var booksInCart: [Book] = []
//    
//    var cartFromBackend : [Book] = []
//    var retrievedUserInfo: userInfoResponseDataStruct!
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//        view.backgroundColor = .white
//        
//        //Initialize tableView
//        cartTableView = UITableView()
//        cartTableView.translatesAutoresizingMaskIntoConstraints = false
//        cartTableView.dataSource = self
//        cartTableView.delegate = self
//        cartTableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.cartTableViewCellIdentifier)
//        cartTableView.backgroundColor = .white
//        cartTableView.layer.cornerRadius = 20
//        cartTableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
//        cartTableView.clipsToBounds = true
//        cartTableView.showsVerticalScrollIndicator = false
//        cartTableView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
//        cartTableView.bounces = false
//        cartTableView.separatorStyle = .none
//        view.addSubview(cartTableView)
//        
//        blackLine = UILabel()
//        blackLine.translatesAutoresizingMaskIntoConstraints = false
//        blackLine.backgroundColor = .black
//        blackLine.isUserInteractionEnabled = false
//        view.addSubview(blackLine)
//        
//        cartTotalLabelLeft = LeftLabel()
//        cartTotalLabelLeft.translatesAutoresizingMaskIntoConstraints = false
//        cartTotalLabelLeft.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//        cartTotalLabelLeft.layer.cornerRadius = 20
//        cartTotalLabelLeft.layer.maskedCorners = [.layerMinXMaxYCorner]
//        cartTotalLabelLeft.clipsToBounds = true
//        cartTotalLabelLeft.text = "Total"
//        cartTotalLabelLeft.isUserInteractionEnabled = false
//        cartTotalLabelLeft.font = .systemFont(ofSize: 20)
//        view.addSubview(cartTotalLabelLeft)
//        
//        cartTotalLabelRight = RightLabel()
//        cartTotalLabelRight.translatesAutoresizingMaskIntoConstraints = false
//        cartTotalLabelRight.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//        cartTotalLabelRight.layer.cornerRadius = 20
//        cartTotalLabelRight.layer.maskedCorners = [.layerMaxXMaxYCorner]
//        cartTotalLabelRight.clipsToBounds = true
//        cartTotalLabelRight.text = "$ 0"
//        cartTotalLabelRight.textAlignment = .right
//        cartTotalLabelRight.isUserInteractionEnabled = false
//        cartTotalLabelRight.font = .systemFont(ofSize: 20)
//        view.addSubview(cartTotalLabelRight)
//        
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
//        
//        //retrieveUserCart()
//        setupConstraints()
//    }
//    
//    override func viewDidAppear(_ animated: Bool){
//        retrieveUserCart()
//    }
//    
//    func setupConstraints(){
//        NSLayoutConstraint.activate([
//            cartTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: sidePadding),
//            cartTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -sidePadding),
//            cartTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
//            cartTableView.heightAnchor.constraint(equalToConstant: view.frame.height*0.5)
//        ])
//        
//        NSLayoutConstraint.activate([
//            blackLine.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: sidePadding),
//            blackLine.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -sidePadding),
//            blackLine.topAnchor.constraint(equalTo: cartTableView.bottomAnchor),
//            blackLine.heightAnchor.constraint(equalToConstant: 1)
//        ])
//        
//        NSLayoutConstraint.activate([
//            cartTotalLabelLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: sidePadding),
//            cartTotalLabelLeft.topAnchor.constraint(equalTo: blackLine.bottomAnchor),
//            cartTotalLabelLeft.heightAnchor.constraint(equalToConstant: 50),
//            cartTotalLabelLeft.widthAnchor.constraint(equalToConstant: (view.frame.width-sidePadding*2)/2)
//        ])
//        
//        NSLayoutConstraint.activate([
//            cartTotalLabelRight.leadingAnchor.constraint(equalTo: cartTotalLabelLeft.trailingAnchor),
//            cartTotalLabelRight.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -sidePadding),
//            cartTotalLabelRight.topAnchor.constraint(equalTo: blackLine.bottomAnchor),
//            cartTotalLabelRight.heightAnchor.constraint(equalToConstant: 50)
//        ])
//        
//        NSLayoutConstraint.activate([
//            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
//            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
//            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
//            confirmButton.heightAnchor.constraint(equalToConstant: 40)
//        ])
//    }
//    
//    private func retrieveUserCart(){
//        
//        let sellerID :Int = LoginViewController.currentUser.id //this is correct now
//        
//        var cartFromBackend : [Book] = []
//        self.booksInCart = []
//        self.totalValue = 0
//        self.cartTotalLabelRight.text = String(format: "%.2f", self.totalValue)
//        
//        self.cartTableView.reloadData()
//        
//        NetworkManager.getUserCart(currentUserId: sellerID){ books in
//            cartFromBackend = books
//            for item in cartFromBackend{
//                let newItem = item
//                self.booksInCart.append(newItem)
//                self.totalValue += Double(newItem.price)!
//                self.cartTotalLabelRight.text = String(format: "%.2f", self.totalValue)
//                
//            }
//            
//            //reload
//            DispatchQueue.main.async {
//                self.cartTableView.reloadData()
//            }
//        }
//        
//        
//    }
//    
//    private func updateCartAfterDelete(deletedBookID:Int){
//        
//        let books = booksInCart
//        booksInCart = []
//        for b in books{
//            if b.id != deletedBookID{
//                booksInCart.append(b)
//            }
//            else{
//                self.totalValue -= Double(b.price)!
//                self.cartTotalLabelRight.text = String(format: "%.2f", self.totalValue)
//            }
//        }
// 
//        //reload
//        DispatchQueue.main.async {
//            self.cartTableView.reloadData()
//        }
//
//    }
//    
//    
//    @objc func confirmButtonTapped(){
//        let newViewController = SuccessViewController()
//        navigationController?.pushViewController(newViewController, animated: true)
//    }
//    
//   
//}
//
//extension CartViewController:UITableViewDataSource{
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Items"
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //return currentCart.count
//        return booksInCart.count
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.cartTableViewCellIdentifier, for: indexPath) as! CartTableViewCell
//        //let oneBook = currentCart[indexPath.row]
//        let oneBook = booksInCart[indexPath.row]
//        cell.configure(inputbookData: oneBook)
//        cell.delegate = self
//        return cell
//    }
//    
//    
//}
//
//extension CartViewController:UITableViewDelegate{
//    
//}
//
//extension UIView {
//    
//    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
//    
//}
//
//extension CartViewController:deleteFromCart{
//    
//    func deleteFromCartAction(bookId: Int) {
//        
//        let sellerID :Int = LoginViewController.currentUser.id
//        let updateToken:String = LoginViewController.currentUser.update_token
//        
//        //call network manager to delete the book
//        NetworkManager.deleteOneBookFromCart(currentUserId: sellerID, bookId: bookId,updateToken: updateToken){ books in //returned cart is not used
//            //call retrieve user cart to update cart information
//            self.updateCartAfterDelete(deletedBookID: bookId)
//        }
//        
//        
//        
//        
//    }
}
