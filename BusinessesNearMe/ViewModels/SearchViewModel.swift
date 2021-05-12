//
//  SearchViewModel.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/11/21.
//

import Foundation

class SearchViewModel {
  
  var businessSearchService: SearchService
  private var businesses: [Business] = []
  
  init(searchService: SearchService = BusinessSearchService()) {
    self.businessSearchService = searchService
  }
  
  func getBusiness(searchTerm: String, latitude: Double, longitude: Double) {
    
    businessSearchService.getBusinesses(searchTerm: searchTerm, latitude: latitude, longitude: longitude) { result in
      switch result {
      case .success(let dataReceived):
        self.businesses = dataReceived.businesses ?? []
        print(dataReceived)
      case .failure(let error):
        print("Failed to get data from Yelp API with error: \(error.localizedDescription)")
      }
    }
  }
}
