//
//  SearchViewModel.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/11/21.
//

import Foundation

class SearchViewModel {
  
  var businessSearchService: SearchService
  private var businesses = [Business]() {
    didSet {
      self.updateView?()
    }
  }
  var updateView: (() -> Void)?
  
  init(searchService: SearchService = BusinessSearchService()) {
    self.businessSearchService = searchService
  }
  
  var numberBusinessesFound: Int {
    return businesses.count
  }
  
  func getBusiness(searchTerm: String, latitude: Double, longitude: Double) {
    
    DispatchQueue.main.async {
      self.businessSearchService.getBusinesses(searchTerm: searchTerm, latitude: latitude, longitude: longitude) { result in
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
}

// MARK: - Helper functions to access data
extension SearchViewModel {
  
  func getBusinesses() -> [Business] {
    return businesses
  }
  
  func infoBusinessViewModel(for index: Int) -> BusinessInfoViewModel {
    let viewModel = BusinessInfoViewModel(businesses[index])
    return viewModel
  }
}
