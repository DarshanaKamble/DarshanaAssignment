//
//  VideoData.swift
//  DarshanaAssignment
//
//  Created by Apple on 11/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

struct VideoData : Decodable {
    
    var video : [Video]
    
    private enum CodingKeys : String,CodingKey {
        case video="results"
    }
    
}

struct Video : Decodable{
    
    var key : String?
    private enum CodingKeys : String,CodingKey {
        case key="key"
    }
}

