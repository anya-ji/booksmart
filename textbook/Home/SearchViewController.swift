//
//  SearchViewController.swift
//  textbook
//
//  Created by Jessica Wu on 12/11/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchControllerOne = UISearchController(searchResultsController: nil)
    var initialText: String
    var resultLabel: UILabel!
    var resultNumberLabel: UILabel!
    var searchTableView: UITableView!
    let searchCellReuseIdentifier = "searchCellReuseIdentifier"
    var filteredBooks: [Book] = []
    
    //    // array holds fake data, remove later
    //    var books: [bookData] = []
    
    init(initialText: String?) {
        self.initialText = initialText ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        
        navigationItem.searchController = searchControllerOne
        searchControllerOne.searchResultsUpdater = self
        searchControllerOne.hidesNavigationBarDuringPresentation = false
        searchControllerOne.obscuresBackgroundDuringPresentation = false
        searchControllerOne.searchBar.placeholder = "Search by ISBN, Title, or Author's Name"
        searchControllerOne.searchBar.text = initialText
        searchControllerOne.searchBar.showsCancelButton = true
        definesPresentationContext = true
        
        searchTableView = UITableView()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: searchCellReuseIdentifier)
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        //searchTableView.separatorStyle = .none
        view.addSubview(searchTableView)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
        resultLabel = UILabel()
        resultLabel.textColor = .black
        resultLabel.font = .boldSystemFont(ofSize: 28)
        resultLabel.text = "Search Results"
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        
        resultNumberLabel = UILabel()
        resultNumberLabel.textColor = .black
        resultNumberLabel.font = .systemFont(ofSize: 15)
        resultNumberLabel.text = "(" + String(filteredBooks.count) + ")"
        resultNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultNumberLabel)
        
    }
    
    func setupConstraints() {
        
        let width: CGFloat = view.frame.width
        //let height: CGFloat = view.frame.height
        
        NSLayoutConstraint.activate([
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            resultLabel.widthAnchor.constraint(equalToConstant: 195),
            resultLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            resultNumberLabel.leadingAnchor.constraint(equalTo: resultLabel.trailingAnchor),
            resultNumberLabel.bottomAnchor.constraint(equalTo: resultLabel.bottomAnchor),
            resultNumberLabel.widthAnchor.constraint(equalToConstant: 30),
            resultNumberLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: width*20/414),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: width * -20/414),
            searchTableView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            searchTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func filterForSearchText(_  searchText: String) {
        NetworkManager.searchBooks(name: searchText) { (books) in
            self.filteredBooks = books
            self.reloadTableView()
        }
    }
    
    func reloadTableView() {
        if let resultLabel = resultNumberLabel {
            resultLabel.text = "(" + String(filteredBooks.count) + ")"
        }
        if let tableView = searchTableView {
            tableView.reloadData()
        }
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterForSearchText(searchBar.text!)
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height*144/896
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: push screen containing book info
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchCellReuseIdentifier, for: indexPath) as! SearchTableViewCell
        cell.configure(inputBookData: filteredBooks[indexPath.item])
        cell.productInfoDelegate = self
        return cell
    }
}


extension SearchViewController: SearchShowProductInfoProtocol{
    
    func showProductInfoFromSearch(inputBook: Book) {
        let productInfo = ProductInfoViewController(inputBook: inputBook)
        navigationController?.pushViewController(productInfo, animated: true)
    }
}
