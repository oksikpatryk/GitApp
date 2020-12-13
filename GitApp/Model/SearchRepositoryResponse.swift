//
//  SearchRepositoryResponse.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import Foundation

struct SearchRepositoryResponse: Decodable {
    var items: [Repository]
}
