//
//  TileLayer.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 6/3/25.
//


// TileLayer.swift - Model for tile-based layers

import Foundation

struct TileLayer: Codable {
    let name: String
    let type: String
    let data: [Int]
    let width: Int
    let height: Int
    let visible: Bool
}
