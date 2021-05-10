//
//  MapViewController.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//

import MapKit
import YelpAPI

public let YelpAPIKey = "uKD9DAyCNSie9pqJ77KMv7N1fRwU8B202P9ym9H1ztI3WDqGNvrfF_MkC2y9XRqiVWsWgLvjGoHOdBBn2ncKYoPFrEqRcUhEeYxWveRdUm69vZTmaya-HOe91FxZXnYx"

class MapViewController: BaseViewController {
  
  private var businesses: [YLPBusiness] = []
  private var client = YLPClient(apiKey: YelpAPIKey)
  private var locationManager = CLLocationManager()
  var mapView: MKMapView?
  
  //The range (meter) of how much we want to see arround the user's location
  let distanceSpan: Double = 500
  
  
  override func commonInit() {
    setTabBarImage(imageName: "map", title: "Map View")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView = MKMapView()
    view = mapView
    
  }
}

extension MapViewController: CLLocationManagerDelegate {
  
}

extension MapViewController: MKMapViewDelegate {
  
}
