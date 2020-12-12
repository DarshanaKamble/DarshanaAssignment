//
//  SimilarMovieData.swift
//  DarshanaAssignment
//
//  Created by Apple on 10/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

struct SimilarData : Decodable {
    let movie : [SameData]
    
    private enum CodingKeys : String,CodingKey{
        case movie="results"
    }
}

struct SameData : Decodable {

    var title : String?
    var posterImage : String?

    private enum CodingKeys : String,CodingKey {
        case title
        case posterImage="poster_path"
    }
}
