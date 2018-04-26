//
//  Movie.swift
//  AsyncTesting
//
//  Created by C4Q on 4/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
struct MovieSearch: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let trackName: String
    let artistName: String
    let contentAdvisoryRating: String // "Unrated"
    let artworkUrl100: String
}

