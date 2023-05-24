//
//  ArticleCellViewModel.swift
//  Sample
//
//  Created by Prabhat Pandey on 23/05/23.
//

import Foundation

struct JokeCellViewModel {
    var title: String
    var isUpdate: Bool
    
    init(joke: Joke) {
        self.title = joke.name
        self.isUpdate = joke.isUpdate
    }
}
