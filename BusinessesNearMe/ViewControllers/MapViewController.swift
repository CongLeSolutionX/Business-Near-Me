//
//  MapViewController.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//

import MapKit
import CoreLocation


class MapViewController: BaseViewController {
  lazy var headerTitle = makeHeaderTitle()
  var businessMapViewModel = BusinessMapViewModel()
  
  private var locationManager = CLLocationManager()
  
  lazy var mapView:MKMapView = {
    let mapView = MKMapView()
    mapView.mapType = .standard
    mapView.isZoomEnabled = true
    mapView.isScrollEnabled = true
    mapView.showsUserLocation = true
    return mapView
  }()
  
  
  override func commonInit() {
    setTabBarImage(imageName: "map", title: "Map View")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMapView()
    showCurrentLocation()
    setupNavBar()
    mapView.delegate = self
  }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // Print out the current locations
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    print("locations = \(locValue.latitude) \(locValue.longitude)")
    
    // Set up the map view
    guard let location = locations.last else { return }
    let centerPoint = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    centerMap(on: centerPoint)
  }
}

// MARK: - Helper functions
extension MapViewController {
  func showCurrentLocation() {
    // Show current location on the map view
    if let coor = mapView.userLocation.location?.coordinate {
      mapView.setCenter(coor, animated: true)
    }
  }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    centerMap(on: userLocation.coordinate)
    DispatchQueue.main.async {
      // Show business around user's current location
      self.addAnnotations()
    }
  }
  
  // MARK: Helper function for MKMapView
  private func centerMap(on coordinate: CLLocationCoordinate2D) {
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
    
    // Pass the coordiate of the current user's location and fetch the data from Yelp API
    self.businessMapViewModel.fetchYelpBusinesses(latitude: coordinate.latitude, longitude: coordinate.longitude)
  }
  
  func addAnnotations() {
    for store in businessMapViewModel.getBusinesses() {
      guard let storeCoordinate = store.coordinates else {
        continue
      }
      
      let coordinate = CLLocationCoordinate2D(
        latitude: storeCoordinate.latitude ?? 0.0,
        longitude: storeCoordinate.longitude ?? 0.0
      )
   
      let annotation = MKPointAnnotation()
      annotation.title = store.name
      annotation.subtitle = store.location?.address1
      annotation.coordinate = coordinate
  
      mapView.addAnnotation(annotation)
    }
  }
}


// MARK: - Setup UI Elements
extension MapViewController {
  
  func setupMapView() {
    view.addSubview(mapView)
    mapView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func setupNavBar() {
    navigationItem.titleView = headerTitle
  }
  
  private func makeHeaderTitle() ->  UILabel{
    let title = UILabel()
    title.text = "Businesses Near Me"
    title.stylizeToCenter(alignment: .center)
    title.font = UIFont.boldSystemFont(ofSize: 20.0)
    return title
  }
}
