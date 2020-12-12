//
//  MovieDetails.swift
//  DarshanaAssignment
//
//  Created by Apple on 10/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct MoviesDetails :Decodable {
    let title : String?
    let overview : String?
    let release_date : String?
    var genre : [Genre]
    var lang : [Language]

    private enum CodingKeys : String,CodingKey{
        case genre="genres"
        case title="title"
        case lang="spoken_languages"
        case overview="overview"
        case release_date="release_date"

    }
    
}

//struct MoviesDetails : Decodable{
//
////    var movieDetails : [MovieDetails]
////    var language : [Language]
//////    var genre : [Genre]
////    var crew : [Crew]
//    var title : String?
//    var releaseDate : String?
//
//    private enum CodingKeys : String,CodingKey{
//
////                case m="spoken_languages"
//
//        case title="title"
//        case releaseDate="release_date"
////
//////        case genre="genres"
////        case crew="production_companies"
////        case language="spoken_languages"
//    }
//}

struct Language : Decodable{
    var englishName : String?
    
    private enum CodingKeys : String,CodingKey {
        case englishName="name"
    }
}

struct Genre : Decodable{
    
    var name : String?
    
    private enum CodingKeys : String,CodingKey {
        case name="name"
    }
}


