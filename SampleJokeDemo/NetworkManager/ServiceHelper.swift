//
//  ServiceHelper.swift
//  Sample
//
//  Created by Admin on 23/05/23.
//

import Foundation

let APIKey = "api"
let kAPIFormat = "json"
let API_BASE_URL = "https://geek-jokes.sameerkumar.website"
let JOKES_API_URL = API_BASE_URL + "/\(APIKey)" + "?format=\(kAPIFormat)"

protocol ServiceHelperProtocol : AnyObject {
    func fetchJokesData(_ completion: @escaping ((Result<JokesData, ErrorResult>) -> Void))
}

final class ServiceHelper : GenericAPIClient, ServiceHelperProtocol {
    
    static let shared = ServiceHelper()
    
    let apiUrlStr = JOKES_API_URL
    var task : URLSessionTask?
    
    func fetchJokesData(_ completion: @escaping ((Result<JokesData, ErrorResult>) -> Void)) {
        // cancel previous request if already in progress
        self.cancelRequest()
        task = APIClient().loadData(urlString: apiUrlStr, completion: self.networkResult(completion: completion))
    }
    
    func cancelRequest() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
