//
//  SearchViewController.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//

import UIKit
import CoreLocation

// These values and used in seach operation
var currentLatitude: Double = 0.0
var currentLongitude: Double  = 0.0


class SearchViewController: BaseViewController {
  var searchViewModel = SearchViewModel()
  var timer: Timer? = nil
  private var locationManager = CLLocationManager()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    // self-sizing cells
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 50.0
    tableView.backgroundColor = .systemBackground
    tableView.allowsSelection = true
    return tableView
  }()
  
  lazy var searchController: UISearchController = {
    let searchController  = UISearchController(searchResultsController: nil)
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Type a store name..."
    searchController.obscuresBackgroundDuringPresentation = false
    return searchController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    determineCurrentLocation()
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
    navigationItem.searchController = searchController
  }
  
  func setUpTableView() {
    // Contraint table to the superview
    view.addSubview(tableView)
    tableView.pin(to: view)
    
    tableView.delegate = self
    tableView.dataSource = self
    
    // get the reusable cells
    tableView.register(BusinessTableViewCell.self, forCellReuseIdentifier: CellID.businessCellId)
    searchViewModel.updateView = { [weak self] in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
  }
}

// MARK: -  UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard let searchTerm = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
    search(searchTerm)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
    search(searchTerm)
  }
  
  func search(_ searchTerm: String) {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false,
                                 block: { [weak self] _ in
                                  self?.searchViewModel.getBusiness(
                                    searchTerm: searchTerm,
                                    latitude: currentLatitude ,
                                    longitude: currentLongitude
                                  )
                                 })
  }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("You tapped cell number \(indexPath.section).")
  }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchViewModel.numberBusinessesFound
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.businessCellId, for: indexPath)
            as? BusinessTableViewCell else {
      fatalError("Cannot dequeue cell")
    }
    // Get data for each cell
    cell.searchBusinessInfoViewModel = searchViewModel.infoBusinessViewModel(for: indexPath.row)
    
    // animate each cell from the left
    cell.slideOutFromLeft()
    return cell
  }
}

// MARK: - Helper functions
extension SearchViewController {
  
  func determineCurrentLocation() {
    locationManager.requestWhenInUseAuthorization()
    // if allowed, the app will get the current location of the user
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.startUpdatingLocation()
    }
  }
}

//MARK: - CLLocationManagerDelegate
extension SearchViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // Print out the current location
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    print("locations = \(locValue.latitude) \(locValue.longitude)")
    
    // Saving these values and used in seach operation
    currentLatitude = locValue.latitude
    currentLongitude = locValue.longitude
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .notDetermined:
      locationManager.requestAlwaysAuthorization()
      break
    case .authorizedWhenInUse:
      locationManager.startUpdatingLocation()
      break
    case .authorizedAlways:
      locationManager.startUpdatingLocation()
      break
    case .restricted:
      // restricted by parental controls. User can't enable Location Services
      break
    case .denied:
      // user denied your app access to Location Services, but can grant access from Settings
      break
    default:
      break
    }
  }
}
