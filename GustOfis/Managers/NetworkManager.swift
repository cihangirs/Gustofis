//
//  NetworkManager.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 30/03/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class NetworkManager: NSObject {

    var sessionManager: SessionManager
    let user = "ck_dda171ed5da512d3f13d3505d7a8d49d18c89a16"
    let password = "cs_3b4dd6cfe76ad7a7f293aab7896df01058bacb5c"
    
    enum API
    {
        static let baseURL = URL(string: "https://gustofisdev.wpengine.com/wp-json/gustofis/v1/")!
    }
    
    private static var sharedNetworkManager: NetworkManager = {
        
        let networkManager = NetworkManager(baseURL: API.baseURL)
        
        return networkManager
    }()
    
    let baseURL: URL
    
    let declaredCompletionHandler: (NSArray) -> Void = {
        print("declaredCompletionHandlerValue: \($0)")
    }
    
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

    func login(user: User, completionHandler: @escaping (_ someArray: User) -> Void)
    {
        let requestStr = "\(API.baseURL)" + "login"
        
        let userDictionary = ["email": user.email!, "password": user.password!]
        
        self.sessionManager.request(requestStr,
                                    method: .post,
                                    parameters: userDictionary,
                                    encoding: URLEncoding.default,
                                    headers: nil).validate().responseObject() { (response: DataResponse<User>) in
                                        
                                        switch response.result
                                        {
                                            case .success:
                                                let user = response.result.value
                                                completionHandler(user!)

                                            case .failure:
                                                debugPrint("failureResponse: \(response)")
                                        }
        }
    }
    
    func createUser(user: User, completionHandler: @escaping (_ someArray: User) -> Void)
    {
        let requestStr = "\(API.baseURL)" + "register"
        
        let userDictionary = ["name": user.name!, "email": user.email!, "password": user.password!]

        self.sessionManager.request(requestStr,
            method: .post,
            parameters: userDictionary,
            encoding: URLEncoding.default,
            headers: nil).validate().responseObject() { (response: DataResponse<User>) in
                
                switch response.result
                {
                    case .success:
                        let user = response.result.value
                        completionHandler(user!)
                    
                    case .failure:
                        debugPrint("failureResponse: \(response)")
                }
        }
    }
    
    func fetchFilters(completionHandler: @escaping (_ someArray: [Filter]) -> Void)
    {
        let requestStr = "\(API.baseURL)" + "filters"
        
        self.sessionManager.request(requestStr,
                                    method: .get,
                                    parameters: nil,
                                    encoding: JSONEncoding.default,
                                    headers: nil).validate().responseArray() { (response: DataResponse<[Filter]>) in
                                        
                                        switch response.result
                                        {
                                        case .success:
                                            let filters = response.result.value
                                            print("filters: \(filters!)")
                                            
//                                            for filter in filters!
//                                            {
//                                                print("productId: \(product.productId!) productName: \(product.name!)")
//                                            }
                                            
                                            completionHandler(filters!)
                                            
                                        case .failure:
                                            debugPrint("failureResponse: \(response)")
                                        }
        }
        
        //        baseRequest(url: requestStr, completionHandler: declaredCompletionHandler)
    }
    
    func fetchCategorieProducts(categorieId: Int, completionHandler: @escaping (_ someArray: [Product]) -> Void)
    {
        let requestStr = "\(API.baseURL)" + "products?category=" + "\(categorieId)"
        
        self.sessionManager.request(requestStr,
                                    method: .get,
                                    parameters: nil,
                                    encoding: JSONEncoding.default,
                                    headers: nil).validate().responseArray() { (response: DataResponse<[Product]>) in
                                        
                                        switch response.result
                                        {
                                        case .success:
                                            let products = response.result.value
                                            print("products: \(products!)")
                                            
                                            for product in products!
                                            {
                                                print("productId: \(product.productId!) productName: \(product.name!)")
                                            }
                                            
                                            completionHandler(products!)
                                            
                                        case .failure:
                                            debugPrint("failureResponse: \(response)")
                                        }
        }
        
        //        baseRequest(url: requestStr, completionHandler: declaredCompletionHandler)
    }
    
    func fetchProducts(completionHandler: @escaping (_ someArray: [Product]) -> Void)
    {
        let requestStr = "\(API.baseURL)" + "products"

        self.sessionManager.request(requestStr,
                                    method: .get,
                                    parameters: nil,
                                    encoding: JSONEncoding.default,
                                    headers: nil).validate().responseArray() { (response: DataResponse<[Product]>) in
                                        
                                        switch response.result
                                        {
                                            case .success:
                                                let products = response.result.value
                                                print("products: \(products!)")
                                                
                                                for product in products!
                                                {
                                                    print("productId: \(product.productId!) productName: \(product.name!)")
                                                }
                                                
                                                completionHandler(products!)
                                            
                                            case .failure:
                                                debugPrint("failureResponse: \(response)")
                                        }
        }
        
//        baseRequest(url: requestStr, completionHandler: declaredCompletionHandler)
    }

    func fetchProductDetail(productId: Int, completionHandler: @escaping (_ someArray: Product) -> Void)
    {
        let requestStr = "\(API.baseURL)" + "product/" + "\(productId)"
        
        self.sessionManager.request(requestStr,
                                    method: .get,
                                    parameters: nil,
                                    encoding: JSONEncoding.default,
                                    headers: nil).validate().responseObject() { (response: DataResponse<Product>) in
                                        
                                        switch response.result
                                        {
                                            case .success:
                                                let product = response.result.value
                                                print("product: \(product!)")
                                                
                                                completionHandler(product!)
                                            
                                            case .failure:
                                                debugPrint("failureResponse: \(response)")
                                            }
        }
        
        //        baseRequest(url: requestStr, completionHandler: declaredCompletionHandler)
    }
    
    func fetchOrders(completionHandler: @escaping (_ someArray: [Order]) -> Void)
    {
        let requestStr = "\(API.baseURL)" + "wp-json/wc/v2/orders"

        self.sessionManager.request(requestStr,
                                    method: .get,
                                    parameters: nil,
                                    encoding: JSONEncoding.default,
                                    headers: nil).validate().responseArray() { (response: DataResponse<[Order]>) in

                                        switch response.result
                                        {
                                            case .success:
                                                let orders = response.result.value
                                                print("orders: \(orders!)")

                                                for order in orders!
                                                {
                                                    print("orderId: \(order.orderId!) parentId: \(order.parentId!)")
                                                }

                                                completionHandler(orders!)

                                            case .failure:
                                                debugPrint("failureResponse: \(response)")
                                        }
        }
        //baseRequest(url: requestStr, completionHandler: completionHandler)
    }
    
    func fetchCategories(completionHandler: @escaping (_ someArray: [Categorie]) -> Void)
    {
        let requestStr = "\(API.baseURL)" + "categories"

        self.sessionManager.request(requestStr,
                                    method: .get,
                                    parameters: nil,
                                    encoding: JSONEncoding.default,
                                    headers: nil).validate().responseArray() { (response: DataResponse<[Categorie]>) in
                                        
                                        switch response.result
                                        {
                                            case .success:
                                                let categories = response.result.value
                                                print("categories: \(categories!)")
                                                
                                                for categorie in categories!
                                                {
                                                    print("categorieId: \(categorie.categorieId!) categorieName: \(categorie.name!)")
                                                }
                                                
                                                completionHandler(categories!)
                                            
                                            case .failure:
                                                debugPrint("failureResponse: \(response)")
                                        }
        }
        
//        baseRequest(url: requestStr, completionHandler: declaredCompletionHandler)
    }
    
    func baseRequest(url: URLConvertible, completionHandler: @escaping (_ someArray: NSArray) -> Void) -> Void
    {
        print(url)

//        self.sessionManager.request(url,
//                                    method: .get,
//                                    parameters: nil,
//                                    encoding: JSONEncoding.default,
//                                    headers: nil).validate().responseArray() { response in
//                                        print("\(response)")
//        }
        
        self.sessionManager.request(url,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: nil).validate().responseArray() { (response: DataResponse<[Order]>) in
            
                switch response.result
                {
                    case .success:
                        if let result = response.result.value
                        {
                            let JSON = result as NSArray
                            print("JSON: \(JSON)")
                            completionHandler(JSON)
                        }
                        else
                        {
                            print("")
                        }

                    case .failure:
                        debugPrint("failureResponse: \(response)")
//                                    completionHandler("fail")
                }
                //let orders = response.result.value
//                for order in orders!
//                {
//                    print("orderId: \(order.orderId!) parentId: \(order.parentId!)")
//                }
        }
        
//        self.sessionManager.request(url,
//                          method: .get,
//                          parameters: nil,
//                          encoding: JSONEncoding.default,
//                          headers: nil).validate().responseJSON { response in
//
//                            //(response: DataResponse<Any>)
//                            print("value: \(response.result.value!)")
//                            print("typeOf value: \(type(of: response.result.value))")
//
//                            switch response.result
//                            {
//                                case .success:
//                                    if let result = response.result.value
//                                    {
//                                        let JSON = result as! NSArray
////                                        dump("unwrappedValue: \(unwrappedValue)")
////                                        print("JSON: \(JSON)")
//
//                                        completionHandler(JSON)
//                                    }
//                                    else
//                                    {
////                                        debugPrint("success valueless response: \(response)")
////                                        completionHandler("")
//                                    }
//
//                                case .failure:
//                                    debugPrint("failureResponse: \(response)")
////                                    completionHandler("fail")
//                            }
//        }
    }
}
