//
//  quizModel.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 11/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import Foundation

struct Quizlist: Codable {
    var quizListing:[QuizEntries]
    
}

struct QuizEntries: Codable {
    let picture: String
    let question: String
    let answers : [String]
}

