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

    private var gameModel: GameModel!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        self.gameModel = GameModel(matchTime: 0, screenSize: self.size)
        let screenRatio = (self.size.width + self.size.height) * 0.1
        
        (0...self.gameModel.enemyPoolSize).forEach { (index) in
            self.gameModel.enemyPool.append(
                EnemyViewModel(
                    size: CGSize(width: screenRatio/2, height: screenRatio/2),
                    position: self.gameModel.spawnEnemyPosition
                )
            )
            self.gameModel.enemyPool[index].addAsChild(context: self)
        }
    }
    
    func getReusableEnemyIndex() -> Int {
        var selectedIndex = -1
        (0...self.gameModel.enemyPoolSize).forEach { (index) in
            if (self.gameModel.enemyPool[index].model.active) {
                selectedIndex = index
            }
        }
        return selectedIndex
    }
    
    func didBegin(_ contact: SKPhysicsContact) {

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
