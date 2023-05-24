//
//  ArticleViewModel.swift
//  Sample
//
//  Created by Prabhat Pandey on 23/05/23.
//

import Foundation

struct JokeViewModel {
    
    weak var dataSource : GenericDataSource<JokeCellViewModel>?
    weak var service: ServiceHelperProtocol?
    
    init(service: ServiceHelperProtocol = ServiceHelper.shared, dataSource : GenericDataSource<JokeCellViewModel>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchJokes(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        
        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        service.fetchJokesData() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let metaData) :
                    // reload data
                    if let serverJokes = metaData.jokes {
                        var jokeItems: [Joke] = []
                        
                        if ((self.dataSource?.data.value ?? []).isEmpty) {
                            jokeItems.append(serverJokes)
                        } else if ((self.dataSource?.data.value ?? []).count == 10) {
                            jokeItems = self.getJokeModel(jokeCellViewModel: self.dataSource?.data.value ?? [])
                            var index = getIndexOfObjectToBeRemoved(jokes: jokeItems)
                            if (index < 0) {
                                resetArray(jokes: jokeItems)
                                index = 0
                            }
                            jokeItems.remove(at: index)
                            serverJokes.isUpdate = true
                            jokeItems.insert(serverJokes, at: index)
                        } else {
                            jokeItems = self.getJokeModel(jokeCellViewModel: self.dataSource?.data.value ?? [])
                            jokeItems.append(serverJokes)
                        }
                        self.dataSource?.data.value = self.getJokeCellViewModelsWith(jokes: jokeItems)
                        completion?(Result.success(true))
                    }
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    completion?(Result.failure(error))
                    break
                }
            }
        }
    }
    
    func getIndexOfObjectToBeRemoved(jokes: [Joke]) -> Int{
        for (index, item) in jokes.enumerated() {
            if (item.isUpdate == false) {
                return index
            }
        }
        return -1
    }
    
    func resetArray(jokes: [Joke]) {
        for item in jokes {
            item.isUpdate = false
        }
    }
    
    func  getJokeCellViewModelsWith(jokes: [Joke]) -> [JokeCellViewModel] {
        var jokeCellVMList: [JokeCellViewModel] = []
        for joke in jokes {
            let jokeCellViewModel = JokeCellViewModel(joke: joke)
            jokeCellVMList.append(jokeCellViewModel)
        }
        return jokeCellVMList
    }
    
    func  getJokeModel(jokeCellViewModel: [JokeCellViewModel]) -> [Joke] {
        var jokeList: [Joke] = []
        for jokeData in jokeCellViewModel {
            let joke = Joke(joke: jokeData.title, isUpdate: jokeData.isUpdate)
            jokeList.append(joke!)
        }
        return jokeList
    }
}
