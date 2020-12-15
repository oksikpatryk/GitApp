//
//  Commit.swift
//  GitApp
//
//  Created by patryk.oksik on 15/12/2020.
//

import Foundation

class Commit: Decodable {
    var author: CommitAuthor
    var message: String
}
