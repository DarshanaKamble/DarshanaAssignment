//
//  MoviesData.swift
//  DarshanaAssignment
//
//  Created by Apple on 09/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct MoviesData : Decodable {
    let movie : [Movie]
    
    private enum CodingKeys : String,CodingKey{
        case movie="results"
    }
}
//
struct Movie : Decodable {

    var title : String?
    var releaseDate : String?
    var overview : String?
    var posterImage : String?
    var rate : Double?
    var year : String?
    var id : Int?
    
    
    private enum CodingKeys : String,CodingKey {
        case title,overview
        case year="release_date"
        case rate="vote_average"
        case posterImage="poster_path"
        case id="id"
    }
}
