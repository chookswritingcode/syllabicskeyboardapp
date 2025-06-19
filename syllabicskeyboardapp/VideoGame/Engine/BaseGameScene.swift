//
//  BaseGameScene.swift
//  AncestralVillage
//
//  Created by Carter Davidson on 2025-06-02.
//

import SpriteKit




// Direction enum for movement commands
enum MoveDirection {
    case up, down, left, right
}

class BaseGameScene: SKScene {
    var player: SKSpriteNode!
    private var cameraNode: SKCameraNode!

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupEnvironment()
        setupPlayer()
        setupCamera()
    }

    func setupEnvironment() {
        // To be overridden by subclasses
    }

    func setupPlayer() {
        player = SKSpriteNode(imageNamed: "player_front")
        player.position = CGPoint(x: 0, y: 0)
        player.zPosition = 10
        addChild(player)
    }

    func setupCamera() {
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode)
        centerCameraOnPlayer()
        
        cameraNode.setScale(8)
    }

    func centerCameraOnPlayer() {
        cameraNode.position = player.position
    }
    
    override func didSimulatePhysics() {
        camera?.position = player.position
        super.didSimulatePhysics()
        centerCameraOnPlayer()
    }

    func movePlayer(_ direction: MoveDirection) {
        let vector: CGVector

        switch direction {
        case .up: vector = CGVector(dx: 0, dy: 1)
        case .down: vector = CGVector(dx: 0, dy: -1)
        case .left: vector = CGVector(dx: -1, dy: 0)
        case .right: vector = CGVector(dx: 1, dy: 0)
        }

        Engine.movePlayer(player, direction: vector)
    }
}
