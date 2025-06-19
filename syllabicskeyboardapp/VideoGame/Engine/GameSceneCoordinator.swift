//
//  GameSceneCoordinator.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 6/3/25.
//


import Foundation
import SpriteKit

@MainActor
class GameSceneCoordinator: ObservableObject {
    let scene: BaseGameScene

    init() {
        // Customize your scene subclass if needed
        self.scene = BaseGameScene(size: CGSize(width: 800, height: 600))
        self.scene.scaleMode = .resizeFill
    }

    func move(_ direction: MoveDirection) {
        scene.movePlayer(direction)
    }
}
