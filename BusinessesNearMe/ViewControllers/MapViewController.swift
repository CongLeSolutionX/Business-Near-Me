//
//  MapViewController.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//

import MapKit
import YelpAPI
import CoreLocation

public let YelpAPIKey = "uKD9DAyCNSie9pqJ77KMv7N1fRwU8B202P9ym9H1ztI3WDqGNvrfF_MkC2y9XRqiVWsWgLvjGoHOdBBn2ncKYoPFrEqRcUhEeYxWveRdUm69vZTmaya-HOe91FxZXnYx"

class MapViewController: BaseViewController {
  
  private var businesses: [YLPBusiness] = []
  private var client = YLPClient(apiKey: YelpAPIKey)
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
    mapView.delegate = self
  }
}

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

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    centerMap(on: userLocation.coordinate)
  }
  
  private func centerMap(on coordinate: CLLocationCoordinate2D) {
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
    
    searchForBusinesses()
    
    // Set up the drop pin
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    annotation.title = "Cong Le"
    annotation.subtitle = "Current location"
    mapView.addAnnotation(annotation)
  }
  
  private func searchForBusinesses() {
    
  }
}
