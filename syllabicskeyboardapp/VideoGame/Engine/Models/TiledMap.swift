//
//  TiledMap.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 6/3/25.
//


// TiledMap.swift - Root JSON model for map

import Foundation

struct TiledMap: Codable {
    let height: Int
    let width: Int
    let tileheight: Int
    let tilewidth: Int
    let layers: [Layer]
    let tilesets: [Tileset]
}

enum Layer: Codable {
    case tileLayer(TileLayer)
    case objectGroup(ObjectGroup)

    enum CodingKeys: String, CodingKey {
        case type
    }

    enum LayerType: String, Codable {
        case tilelayer
        case objectgroup
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(LayerType.self, forKey: .type)

        switch type {
        case .tilelayer:
            self = .tileLayer(try TileLayer(from: decoder))
        case .objectgroup:
            self = .objectGroup(try ObjectGroup(from: decoder))
        }
    }

    func encode(to encoder: Encoder) throws {
        switch self {
        case .tileLayer(let layer):
            try layer.encode(to: encoder)
        case .objectGroup(let group):
            try group.encode(to: encoder)
        }
    }
}