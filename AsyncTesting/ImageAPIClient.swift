//
//  ImageAPIClient.swift
//  AsyncTesting
//
//  Created by C4Q on 4/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
   let urlSession = URLSession(configuration: .default)
   func getImages(from urlStr: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
    let urlRequest = URLRequest(url: URL(string: urlStr)!)
    urlSession.dataTask(with: urlRequest) { (data, response, error) in
        DispatchQueue.main.async {
      
        if let error = error {
            completionHandler(nil, error)
        }
        if let data = data {
            guard let image = UIImage(data: data) else {return}
            completionHandler(image, nil)
        }
        }
        
    }.resume()
       
    }
}
