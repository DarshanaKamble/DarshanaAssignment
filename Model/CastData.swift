//
//  CastData.swift
//  DarshanaAssignment
//
//  Created by Apple on 10/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
struct CastData : Decodable {
    let cast : [Cast]
    let crew : [Crew]

    private enum CodingKeys : String,CodingKey{
        case cast="cast"
        case crew="crew"
    }
}

struct Cast : Decodable {
    var name : String?
    var profilePath : String?


    private enum CodingKeys : String,CodingKey {
        case name="name"
        case profilePath="profile_path"
    }
}

struct Crew : Decodable {
    var name : String?
    var profilePath : String?


    private enum CodingKeys : String,CodingKey {
        case name="name"
        case profilePath="profile_path"
    }
}
