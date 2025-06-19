//
//  VillageScene.swift
//  AncestralVillage
//
//  Created by Carter Davidson on 2025-06-02.
//

import SpriteKit

@MainActor
class VillageScene: SKScene {

    var player: SKSpriteNode!

    override func didMove(to view: SKView) {
        backgroundColor = .black

        setupMap()
        setupPlayer()
        setupSwipeGestures(in: view)
    }

    private func setupMap() {
        guard let map = TiledMapLoader.loadMap(named: "village_map") else {
            print("❌ Failed to load map")
            return
        }

        let tileSize = CGSize(width: map.tilewidth, height: map.tileheight)
        let texture = SKTexture(imageNamed: "tileset") // make sure this matches your asset name

        let mapNode = TileMapRenderer.render(map, tilesetTexture: texture, tileSize: tileSize)
        mapNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(mapNode)

        // Register the map to Engine for movement/collision
        Engine.setupTileMap(in: self, with: SKTileSet(tileGroups: [TileMapRenderer.defaultTileGroup(texture: texture)]), columns: map.width, rows: map.height)
    }

    private func setupPlayer() {
        player = SKSpriteNode(imageNamed: "player_front")
        player.size = CGSize(width: 16, height: 16)
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        player.zPosition = 10
        addChild(player)
    }

    private func setupSwipeGestures(in view: SKView) {
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            gesture.direction = direction
            view.addGestureRecognizer(gesture)
        }
    }

    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:    Engine.movePlayer(player, direction: CGVector(dx: 0, dy: 1))
        case .down:  Engine.movePlayer(player, direction: CGVector(dx: 0, dy: -1))
        case .left:  Engine.movePlayer(player, direction: CGVector(dx: -1, dy: 0))
        case .right: Engine.movePlayer(player, direction: CGVector(dx: 1, dy: 0))
        default: break
        }
    }
}
