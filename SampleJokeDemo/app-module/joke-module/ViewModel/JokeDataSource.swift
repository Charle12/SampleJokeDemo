//
//  NewsDataSource.swift
//  Sample
//
//  Created by Prabhat Pandey on 23/05/23.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: GenericValue<[T]> = GenericValue([])
}

class JokeDataSource : GenericDataSource<JokeCellViewModel>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell configuration
        let cell = tableView.dequeueReusableCell(withIdentifier: kJokeCellID, for: indexPath) as! JokeTableViewCell
        cell.selectionStyle = .none
        cell.configCellUI()

        // Set cell data
        let jokeCellVM = self.data.value[indexPath.row]
        cell.jokeCellVM = jokeCellVM
//        cell.nameLabel.text = "Index: \(indexPath.row + 1) : \(jokeCellVM.title)"
        return cell
    }
}

