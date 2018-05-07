//
//  dataModel.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 02/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import Foundation

struct FrameworkList: Codable {
    var frameworkInfo:[Framework]
    
}


struct Framework: Codable {
    let name: String
    let picture: String
    let text: String?
    let stars: Int?
    let format : [String]
    let databases : [String]
    let cloud : [String]
}
