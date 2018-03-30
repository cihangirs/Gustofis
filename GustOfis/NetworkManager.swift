//
//  NetworkManager.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 30/03/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class NetworkManager: NSObject {

    var sessionManager: SessionManager
    let user = "ck_dda171ed5da512d3f13d3505d7a8d49d18c89a16"
    let password = "cs_3b4dd6cfe76ad7a7f293aab7896df01058bacb5c"
    
    enum API
    {
        static let baseURL = URL(string: "https://gustofisdev.wpengine.com/wp-json/wc/v2/")!
    }
    
    private static var sharedNetworkManager: NetworkManager = {
        
        let networkManager = NetworkManager(baseURL: API.baseURL)
        
        return networkManager
    }()
    
    let baseURL: URL
    
    // Initialization
    
    private init(baseURL: URL) {
        self.baseURL = baseURL
        
        // Configuration
        // ...
        // MARK: - Adding headers to all requests in the session
        // get the default headers
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        // add your custom header
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Basic Y2tfZGRhMTcxZWQ1ZGE1MTJkM2YxM2QzNTA1ZDdhOGQ0OWQxOGM4OWExNjpjc18zYjRkZDZjZmU3NmFkN2E3ZjI5M2FhYjc4OTZkZjAxMDU4YmFjYjVj"
        
        // create a custom session configuration
        let configuration = URLSessionConfiguration.default
        // add the headers
        configuration.httpAdditionalHeaders = headers
        
        // create a session manager with the configuration
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    // MARK: - Accessors
    
    class func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    func fetchProducts() -> Void
    {
        let requestStr = "\(API.baseURL)" + "products"
        baseRequest(url: requestStr)
    }
    
    func fetchOrders() -> Void
    {
        let requestStr = "\(API.baseURL)" + "orders"
        baseRequest(url: requestStr)
    }
    
    func fetchCategories() -> Void
    {
        let requestStr = "\(API.baseURL)" + "products/categories"
        baseRequest(url: requestStr)
    }
    
    func baseRequest(url: URLConvertible) -> Void
    {
        print(url)
        
        self.sessionManager.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil).validate().responseJSON { response in
                            
                            switch response.result
                            {
                                case .success:
                                    if let unwrappedValue = response.result.value
                                    {
                                        dump("unwrappedValue: \(unwrappedValue)")
                                    }
                                    else
                                    {
                                        debugPrint("success valueless response: \(response)")
                                    }
                                case .failure:
                                    debugPrint("failureResponse: \(response)")
                            }
        }
    }
}
