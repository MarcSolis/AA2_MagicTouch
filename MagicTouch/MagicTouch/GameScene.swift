//
//  GameScene.swift
//  MagicTouch
//
//  Created by Alumne on 6/5/21.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {

    private let enemyPoolSize = 15

    private var gameModel: GameModel!
    private var enemyPool: [EnemyViewModel]!

    override func didMove(to view: SKView) {
        self.gameModel = GameModel( score: 0, matchTime: 0)
        self.enemyPool = []
        let screenRatio = (self.size.width + self.size.height) * 0.1
        (0...enemyPoolSize).forEach { (index) in
            self.enemyPool.append(
                EnemyViewModel(
                    size: CGSize(width: screenRatio/2, height: screenRatio/2),
                    position: CGPoint(x: index*80, y: 0)
                )
            )
            self.addChild(self.enemyPool[index].view)

        }
    }

    func touchDown(atPoint pos: CGPoint) {

    }

    func touchMoved(toPoint pos: CGPoint) {

    }

    func touchUp(atPoint pos: CGPoint) {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
