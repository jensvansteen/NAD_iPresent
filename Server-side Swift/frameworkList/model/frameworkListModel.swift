//
//  dataModel.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 02/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import Foundation
import UIKit

struct FrameworkList: Codable {
    var frameworkInfo:[Framework]
    var formatInfo: Dictionary<String, card>
    var databaseInfo: Dictionary<String, card>
    var cloudInfo: Dictionary<String, card>
    
}

struct card: Codable {
    let picture: String
    let name: String
    let url: String
    let color: [CGFloat]
    let textColor: [CGFloat]
}


struct Framework: Codable {
    let name: String
    let picture: String
    let text: String?
    let github: String
    let format : [String]
    let databases : [String]
    let cloud : [String]
}

struct Github: Codable {
    let stargazers_count: Int
}
