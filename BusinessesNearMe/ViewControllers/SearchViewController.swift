//
//  SearchViewController.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//

import UIKit

class SearchViewController: BaseViewController {
  
  var searchResults: [BusinessSite] = []
  let tableView = UITableView()
  lazy var searchBar = makeSearchBar()
  
  lazy var tapRecognizeer: UITapGestureRecognizer =  {
    var recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    return recognizer
  }()
  
  override func loadView() {
    super.loadView()
    setUpTableView()
    setupSearchBar()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
  }
  
  override func commonInit() {
    setTabBarImage(imageName: "magnifyingglass.circle", title: "Search View")
  }

}

// MARK: - Set up Search Bar UI
extension SearchViewController {
  private func makeSearchBar() -> UISearchBar{
    let searchBar = UISearchBar()
    searchBar.searchBarStyle = UISearchBar.Style.prominent
    searchBar.placeholder = " Search bussiness by name..."
    searchBar.sizeToFit()
    searchBar.isTranslucent = false
    searchBar.backgroundImage = UIImage()
    searchBar.delegate = self
    return searchBar
  }
}

// MARK: - Setup search bar and table view
extension SearchViewController {
  
  func setupSearchBar() {
    view.addSubview(searchBar)
    navigationItem.titleView = searchBar
  }
  
  func setUpTableView() {
    // Contrain table to the superview
    view.addSubview(tableView)
    tableView.pin(to: view)
    
    tableView.delegate = self
    tableView.dataSource = self
    
    // self-sizing cells
    tableView.rowHeight = UITableView.automaticDimension
    tableView.backgroundColor = UIColor.yellow
    //    tableView.separatorStyle = .none
    //    tableView.allowsSelection = true
    
    // get the reusable cells
    tableView.register(BusinessCell.self, forCellReuseIdentifier: BusinessCell.identifier)
    tableView.reloadData()
  }
}


// MARK: -  UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searched: UISearchBar) {
    dismissKeyboard()
    
    guard let searchText = searchBar.text, !searchText.isEmpty else { return }
    
    //    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
//    queryService.getSearchResults(searchTerm: searchText) { [weak self] searchReuslts, error in
//      //      UIApplication.shared.isNetworkActivityIndicatorVisible = false
//
//      guard let results = searchReuslts else { return }
//      self?.searchResults = results
//      self?.tableView.reloadData()
//      self?.tableView.setContentOffset(CGPoint.zero, animated: false)
//
//      if !error.isEmpty {
//        print("Failure in searching with error: \(error)")
//      }
//    }
  }
  
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    view.addGestureRecognizer(tapRecognizeer)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    view.removeGestureRecognizer(tapRecognizeer)
  }
  
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    /// Use default style and safely unwrap the `TrackCell`
    guard let cell: BusinessCell = tableView.dequeueReusableCell(withIdentifier: BusinessCell.identifier, for: indexPath) as? BusinessCell else {
      let cell = BusinessCell(style: .default, reuseIdentifier: BusinessCell.identifier)
      return cell
    }
    
    /// Delegate cell button tap events to this view controller
//    cell.delegate = self
    
    let track = searchResults[indexPath.row]
//    cell.configure(track: track, download: track.downloaded)
    
    return cell
  }
}


// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    /// When user tap cell, play the local file, if it's downloaded
    let track = searchResults[indexPath.row]
    
//    if track.downloaded {
//      playDownload(track)
//    }
//
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 62.0
  }
}

// MARK: - Helper methods
extension SearchViewController {
  @objc func dismissKeyboard() {
    searchBar.resignFirstResponder()
  }
}
