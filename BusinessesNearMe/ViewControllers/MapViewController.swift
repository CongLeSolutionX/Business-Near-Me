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
    return mapView
  }()
  
  
  override func commonInit() {
    setTabBarImage(imageName: "map", title: "Map View")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMapView()
    determineCurrentLocation()
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

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error - locationManager: \(error.localizedDescription)")
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
      // restricted by e.g. parental controls. User can't enable Location Services
      break
    case .denied:
      // user denied your app access to Location Services, but can grant access from Settings.app
      break
    default:
      break
    }
  }
}

// MARK: - Helper functions
extension MapViewController {
  func determineCurrentLocation() {
    
    locationManager.requestWhenInUseAuthorization()
    // if allowed, the app will get the current location of the user
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.startUpdatingLocation()
    }
    
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
  }
  
  // MARK: Helper function for MKMapView
  private func centerMap(on coordinate: CLLocationCoordinate2D) {
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
    
    // Pass the coordiate of the current user's location and get the
    businessMapViewModel.fetchYelpBusinesses(latitude: coordinate.latitude, longitude: coordinate.longitude)
    
    // Set up the drop pin for current user's location
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    annotation.title = "Cong Le"
    annotation.subtitle = "Current location"
    mapView.addAnnotation(annotation)
  }

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let viewModel = annotation as? BusinessMapViewModel else {
      return nil
    }
    let identifier = "businessLocation"
    let annotationView: MKAnnotationView
    
    if let existingView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
      annotationView = existingView
    } else {
      annotationView = MKAnnotationView(annotation: viewModel as! MKAnnotation, reuseIdentifier: identifier)
    }
    
    return annotationView
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
