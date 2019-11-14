//
//  NetworkManager.swift
//  NYT
//
//  Created by Alex Lebedev on 12.11.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import Foundation
import Alamofire

enum ResponseError: LocalizedError {
    case internetNotAvailable
    
    var errorDescription: String? {
        switch self {
        case .internetNotAvailable:
            return "Internet not available"
        }
    }
}

class NetworkManager {
    
    func getRequest(category: String, completion: @escaping(Result<Any?>) -> Void) {
        guard Reachability.isInternetAvailable else {
            completion(Result.failure(ResponseError.internetNotAvailable))
            return
        }
            let apiUrl = "https://api.nytimes.com/svc/topstories/v2/\(category).json?api-key=WGqIve4nFGf2kLLYUkNFsVL8UDIeQ7hj"
                Alamofire.request(apiUrl).validate().responseJSON { response in
            completion(.success(response.result.value))

    }
}
}


