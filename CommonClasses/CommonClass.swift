//
//  CommonClass.swift
//  DarshanaAssignment
//
//  Created by Apple on 11/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class CommonClass{
    
    
    static var selectedMovieID : String?
    
    static func getNavBarHeight(navigationController : UINavigationController)->CGFloat{
        var navbarHeight:CGFloat=0.0
        
        navbarHeight=(navigationController.navigationBar.frame.height)
        let statusBarHeight=UIApplication.shared.statusBarFrame.height
        
        navbarHeight=navbarHeight+statusBarHeight
        
        return navbarHeight
    }
    
}

struct CommonColor{
    
    static let navBarColor : UIColor=UIColor(red: 172/255, green: 153/255, blue: 231/255, alpha: 1)
}
