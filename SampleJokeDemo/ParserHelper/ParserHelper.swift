//
//  ParserHelper.swift
//  Sample
//
//  Created by Admin on 23/05/23.
//

import Foundation

protocol Parsable {
    static func parseObject(dictionary: [String: String]?) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    
    static func parse<T: Parsable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        do {
        
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String] {
                // init final result
                // check foreach dictionary if parseable
                switch T.parseObject(dictionary: dictionary) {
                case .failure(let error):
                    completion(.failure(error))
                    break
                case .success(let newModel):
                    completion(.success(newModel))
                    break
                }
            } else {
                NSLog("Json data is not an array")
                completion(.failure(.parser(string:kAPIParseErrorMessgae)))
            }
        } catch {
            // can't parse json
            NSLog("Error while parsing json data")
            completion(.failure(.parser(string:kAPIParseErrorMessgae)))
        }
    }
}
