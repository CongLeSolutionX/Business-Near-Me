//
//  SearchViewController.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//

import UIKit

class SearchViewController: BaseViewController {
  var searchViewModel = SearchViewModel()
  let tableView = UITableView()
  
  private let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
    setupSearchBar()
  }
  
  override func commonInit() {
    setTabBarImage(imageName: "magnifyingglass.circle", title: "Search View")
  }
  
}
// MARK: - Setup search bar and table view
extension SearchViewController {
  
  func setupSearchBar() {
    self.title = "Search Store Near Me"
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Type a store name..."
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
    
  }
  
  func setUpTableView() {
    // Contraint table to the superview
    view.addSubview(tableView)
    tableView.pin(to: view)
    
    tableView.delegate = self
    //    tableView.dataSource = self
    
    // self-sizing cells
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 50.0
    tableView.backgroundColor = .systemBackground
    //    tableView.separatorStyle = .none
    //    tableView.allowsSelection = true
    
    // get the reusable cells
    tableView.register(BusinessTableViewCell.self, forCellReuseIdentifier: CellID.businessCellId)
    
  }
}


// MARK: -  UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  
  
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.businessCellId, for: indexPath)
            as? BusinessTableViewCell else {
      fatalError("Cannot dequeue cell")
    }
    
    return cell
  }
  
}


// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
  
}
