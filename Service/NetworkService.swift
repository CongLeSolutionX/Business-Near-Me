//
//  NetworkService.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/11/21.
//

import Foundation

typealias BusinessHandler = (_ result: Result<BussinessLocation, ErrorDescription>) -> Void

protocol yelpBusinessService: AnyObject {
  func fetchBusinesses(latitude: Double, longitude: Double, completionHandler: @escaping BusinessHandler)
}

class NetworkService: yelpBusinessService {
  
  func fetchBusinesses(latitude: Double, longitude: Double, completionHandler: @escaping BusinessHandler) {
    let apikey = "uKD9DAyCNSie9pqJ77KMv7N1fRwU8B202P9ym9H1ztI3WDqGNvrfF_MkC2y9XRqiVWsWgLvjGoHOdBBn2ncKYoPFrEqRcUhEeYxWveRdUm69vZTmaya-HOe91FxZXnYx"
    let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)")
    guard let safeUrl = url else { return }
    
    var requestUrl = URLRequest(url: safeUrl)
    
    requestUrl.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
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