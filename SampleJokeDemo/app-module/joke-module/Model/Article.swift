//
//  Article.swift
//  Sample
//
//  Created by Prabhat Pandey on 23/05/23.
//

import Foundation

struct JokesData {
    var jokes: Joke?
}

extension JokesData: Parsable {
    static func parseObject(dictionary: [String : String]?) -> Result<JokesData, ErrorResult> {
        if let result = dictionary?[JokeConstant.KEY_JOKE] {
            let jokes = Joke(joke: result)
            let meta = JokesData(jokes: jokes)
            return Result.success(meta)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse API response"))
        }
    }

}

class Joke {
    var name: String
    var isUpdate: Bool
    
    init?(joke: String, isUpdate: Bool = false) {
        self.name = joke
        self.isUpdate = isUpdate
    }
}

