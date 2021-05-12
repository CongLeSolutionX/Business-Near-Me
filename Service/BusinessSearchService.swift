//
//  BusinessSearchService.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/11/21.
//

import Foundation

typealias SearchCompletionHandler = (_ result: Result<[Business], ErrorDescription>) -> Void

protocol SearchService {
  func getBusinesses(searchTerm: String, latitude: Double, longitude: Double, completionHandler: @escaping BusinessHandler)
}

class BusinessSearchService: SearchService {
  
  func getBusinesses(searchTerm: String, latitude: Double, longitude: Double, completionHandler: @escaping BusinessHandler) {
    
    guard !searchTerm.isEmpty,
          let url = URL(string: "https://api.yelp.com/v3/businesses/search?text=\(searchTerm)&latitude=\(latitude)&longitude=\(longitude)&limit=25")
    else {
      completionHandler(.failure(.init(errorDescription: "This is not a good URL link")))
      return
    }
   
    var requestUrl = URLRequest(url: url)
    
    requestUrl.setValue("Bearer \(yelpAPIKey)", forHTTPHeaderField: "Authorization")
    requestUrl.httpMethod = "GET"
    let session = URLSession.shared
    
    let task = session.dataTask(with: requestUrl) { (dataReceived, response, errorReceived) in
      if let error = errorReceived {
        completionHandler(.failure(.init(errorDescription: error.localizedDescription)))
        return
      }
      
      if let httpResponse = response as? HTTPURLResponse,
         !(200...299).contains(httpResponse.statusCode) {
        completionHandler(.failure(.init(errorDescription: "Getting error code \(httpResponse.statusCode)")))
      }
      
      guard let data = dataReceived else {
        completionHandler(.failure(.init(errorDescription: "No data returned")))
        return
      }
      
      do {
        let businessData = try JSONDecoder().decode(BussinessLocation.self, from: data)
        completionHandler(.success(businessData))
      } catch {
        completionHandler(.failure(.init(errorDescription: error.localizedDescription)))
        return
      }
    }
    task.resume()
  }
}
