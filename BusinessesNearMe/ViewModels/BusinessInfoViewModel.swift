//
//  BusinessInfoViewModel.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/12/21.
//

import Foundation

class BusinessInfoViewModel {
  private var businessInfo: Business {
    didSet {
      updateView?()
    }
  }
  
  var updateView: (() -> Void)?
  
  init(_ businessInfo: Business) {
    self.businessInfo = businessInfo
  }
  
  var name: String? {
    return businessInfo.name
  }
  
  var rating: Double? {
    return businessInfo.rating
  }
  
  var latitude: Double? {
    return businessInfo.coordinates?.latitude
  }
  
  var longitude: Double? {
    return businessInfo.coordinates?.longitude
  }
  
  var address: String? {
    return businessInfo.location?.address1
  }
}
