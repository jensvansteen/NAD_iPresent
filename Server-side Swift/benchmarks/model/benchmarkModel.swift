//
//  benchmarksEntry.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 05/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import Foundation
import UIKit

struct BenchmarkList: Codable {
    var benchmarkListing:[Benchmark]
    
}


struct Benchmark: Codable {
    let name: String
    let scale: Float
    let results : [Result]
}


struct Result: Codable {
    let name: String
    let value: Float
}

struct BarEntry {
    let color: UIColor
    
    let height: Float
    
    let textValue: String
    
    let title: String
}
