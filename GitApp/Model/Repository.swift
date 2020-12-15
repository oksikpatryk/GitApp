//
//  Repository.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import Foundation

struct Repository: Decodable {
    var name: String
    var stargazers_count: Int
    var owner: Owner
    var html_url: URL
}
