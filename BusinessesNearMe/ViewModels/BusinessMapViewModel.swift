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
