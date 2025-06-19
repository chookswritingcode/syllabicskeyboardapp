//
//  ObjectGroup.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 6/3/25.
//


// ObjectGroup.swift - Model for object layers (triggers, NPCs, etc)

import Foundation
import CoreGraphics

struct ObjectGroup: Codable {
    let name: String
    let type: String
    let objects: [TiledObject]
}

struct TiledObject: Codable {
    let id: Int
    let name: String
    let type: String
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let height: CGFloat
    let properties: [TiledProperty]?

    var frame: CGRect {
        CGRect(x: x, y: y, width: width, height: height)
    }
}

struct TiledProperty: Codable {
    let name: String
    let type: String
    let value: String
}
