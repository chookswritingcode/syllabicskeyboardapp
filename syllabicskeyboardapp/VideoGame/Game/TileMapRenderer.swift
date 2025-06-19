//
//  TileMapRenderer.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 6/3/25.
//

import SpriteKit

@MainActor
class TileMapRenderer {

    static func render(_ map: TiledMap, tilesetTexture: SKTexture, tileSize: CGSize) -> SKNode {
        let rootNode = SKNode()

        for layer in map.layers {
            switch layer {
            case .tileLayer(let tileLayer):
                if tileLayer.visible {
                    let tileMap = SKTileMapNode(
                        tileSet: SKTileSet(tileGroups: [TileMapRenderer.defaultTileGroup(texture: tilesetTexture)]),
                        columns: tileLayer.width,
                        rows: tileLayer.height,
                        tileSize: tileSize
                    )
                    tileMap.name = tileLayer.name
                    tileMap.anchorPoint = CGPoint(x: 0.5, y: 0.5)

                    for row in 0..<tileLayer.height {
                        for col in 0..<tileLayer.width {
                            let index = row * tileLayer.width + col
                            let tileID = tileLayer.data[index]
                            if tileID != 0 {
                                tileMap.setTileGroup(tileMap.tileSet.tileGroups[0], forColumn: col, row: tileLayer.height - 1 - row)
                            }
                        }
                    }

                    rootNode.addChild(tileMap)
                }

            case .objectGroup:
                // Skip for now; handled elsewhere
                break
            }
        }

        return rootNode
    }

    public static func defaultTileGroup(texture: SKTexture) -> SKTileGroup {
        let tileDef = SKTileDefinition(texture: texture)
        let rule = SKTileGroupRule(adjacency: .adjacencyAll, tileDefinitions: [tileDef])
        return SKTileGroup(rules: [rule])
    }
}
