//
//  BusinessMapViewModel.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//
import Foundation
import MapKit

public class BusinessMapViewModel {
  private let service: NetworkService
  private var businesses: [Business] = []

  init(service: NetworkService = NetworkService()) {
    self.service = service
  }
}

// MARK: - Parsing data and store it locally
extension BusinessMapViewModel {
  func fetchYelpBusinesses(latitude: Double, longitude: Double) {
   // get the business around the current user's location
    service.fetchBusinesses(latitude: latitude, longitude: longitude) { result in
      switch result {
      case .success(let businessReceived):
        self.businesses = businessReceived.businesses ?? []
      case .failure(let error):
        print("Failed to get data from Yelp API with error: \(error.localizedDescription)")
      }
    }
  }
}

// MARK: - Helper functions to access data
extension BusinessMapViewModel {
  
  func getBusinesses() -> [Business] {
    return businesses
  }
  
  func getBusinessTitle(_ index: Int) -> String {
    return businesses[index].name ?? "This business does not have a name"
  }
  
  func getBusinessRating(_ index: Int) -> Double {
    return businesses[index].rating ?? 0.0
  }
  
  func getBusinessLatitude(_ index: Int) -> Double {
    return businesses[index].coordinates?.latitude ?? 0.0
  }
  
  func getBusinessLongitude(_ index: Int) -> Double {
    return businesses[index].coordinates?.longitude ?? 0.0
  }
}
