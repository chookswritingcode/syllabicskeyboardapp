//
//  Engine.swift
//  AncestralVillage
//
//  Created by Carter Davidson on 2025-06-02.
//

import SpriteKit
import Foundation

@MainActor
class Engine {

    static let tileSize = CGSize(width: 16, height: 16)
    private(set) static var tileMap: SKTileMapNode?

    // MARK: - TileMap Setup

    static func setupTileMap(in scene: SKScene, with tileSet: SKTileSet, columns: Int, rows: Int) {
        let map = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
        map.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        map.position = CGPoint(x: 0, y: 0)
        scene.addChild(map)
        tileMap = map
    }

    // MARK: - Collision

    static func isTileWalkable(at position: CGPoint) -> Bool {
        guard let tileMap = tileMap else { return false }
        let column = tileMap.tileColumnIndex(fromPosition: position)
        let row = tileMap.tileRowIndex(fromPosition: position)
        let tileDefinition = tileMap.tileDefinition(atColumn: column, row: row)
        return tileDefinition?.userData?["walkable"] as? Bool ?? true  // assume walkable if undefined
    }

    // MARK: - Movement

    static func movePlayer(_ player: SKSpriteNode, direction: CGVector) {
        guard let tileMap = tileMap else { return }

        let newPosition = CGPoint(
            x: player.position.x + direction.dx * tileSize.width,
            y: player.position.y + direction.dy * tileSize.height
        )

        if isTileWalkable(at: newPosition) {
            let moveAction = SKAction.move(to: newPosition, duration: 0.15)
            player.run(moveAction)
        }
    }

    // MARK: - Utility

    static func gridPosition(from point: CGPoint) -> (column: Int, row: Int)? {
        guard let tileMap = tileMap else { return nil }
        let column = tileMap.tileColumnIndex(fromPosition: point)
        let row = tileMap.tileRowIndex(fromPosition: point)
        return (column, row)
    }

    static func pointFromGrid(column: Int, row: Int) -> CGPoint? {
        return tileMap?.centerOfTile(atColumn: column, row: row)
    }
}
