//
//  GameScene.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 6/3/25.
//


// GameScene.swift - Initial game view with movement + tilemap

import SpriteKit

class GameScene: SKScene {

    var player: SKSpriteNode!
    var triggers: [TileTrigger] = []

    override func didMove(to view: SKView) {
        backgroundColor = .black

        // Load map data
        guard let map = TiledMapLoader.loadMap(named: "sample-map") else { return }

        // Load tile texture (placeholder)
        let tileTexture = SKTexture(imageNamed: "tileset-placeholder") // Replace with your real tileset texture
        let tileSize = CGSize(width: 16, height: 16)

        let mapNode = TileMapRenderer.render(map, tilesetTexture: tileTexture, tileSize: tileSize)
        addChild(mapNode)

        // Load triggers
        triggers = TriggerHandler.extractTriggers(from: map)

        // Add player
        player = SKSpriteNode(color: .white, size: CGSize(width: 12, height: 12))
        player.position = CGPoint(x: 0, y: 0)
        player.name = "player"
        addChild(player)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let location = touch.location(in: self)
        let move = SKAction.move(to: location, duration: 0.3)
        player.run(move)

        checkTrigger()
    }

    func checkTrigger() {
        if let trigger = TriggerHandler.checkTriggers(at: player.position, triggers: triggers) {
            print("✅ Trigger hit: \(trigger.name) → \(trigger.destination)")
            // You could call: sceneManager.loadScene(named: trigger.destination)
        }
    }
}
