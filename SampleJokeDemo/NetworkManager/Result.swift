//
//  Result.swift
//  Sample
//
//  Created by Admin on 23/05/23.
//

import Foundation

//MARK:- Service enums
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
