//
//  EnemyViewModel.swift
//  MagicTouch
//
//  Created by Alumne on 18/5/21.
//
import SpriteKit
import Foundation

class EnemyViewModel {
    var model: EnemyModel
    var view: SKSpriteNode
    let disabledPosition: CGPoint!

    init(size: CGSize, position: CGPoint, disabledPosition: CGPoint) {
        self.model = EnemyModel()
        self.disabledPosition = disabledPosition
        self.view = SKSpriteNode(imageNamed: "Enemy")
        self.view.isUserInteractionEnabled = false
        self.view.size = size
        self.view.position = position
        self.view.name = "Enemy"
        self.view.physicsBody = SKPhysicsBody(circleOfRadius: size.width/4)
        self.view.physicsBody!.affectedByGravity = false
        self.view.physicsBody!.collisionBitMask = 0x00000010
        self.view.physicsBody!.contactTestBitMask = 0x00000100
        self.view.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        self.view.physicsBody!.friction = 0
        self.view.physicsBody!.linearDamping = 0
        self.view.zPosition = 1000

        self.model.randomInit(
            minBaloon: 1,
            maxBaloon: 4,
            enemySize: size
        )

    }

    public func destroyBallons(identifier: Int) -> Int {
        (0...model.ballons.count-1).forEach { (index) in
            if model.ballons[index].model.movementId == identifier &&
                !self.model.ballons[index].view.isHidden {
                self.model.ballons[index].view.isHidden = true
                self.model.activeBaloons -= 1
            }
        }
        if self.model.activeBaloons <= 0 {
            kill(disablePos: self.disabledPosition)
            return self.model.points
        }
        return 0
    }

    public func reuse(initialPos: CGPoint) {
        self.view.position = initialPos
        self.model.reuseBaloons()
        self.model.active = true
        self.view.physicsBody!.velocity = self.model.movementSpeed
        (0...self.model.ballons.count-1).forEach { (index) in
            self.model.ballons[index].setVelocity(velocity: self.model.movementSpeed)
        }
    }

    public func kill(disablePos: CGPoint) {
        self.view.position = disablePos
        self.model.active = false
        self.view.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        (0...self.model.ballons.count-1).forEach { (index) in
            self.model.ballons[index].setVelocity(velocity: CGVector(dx: 0, dy: 0))
        }
    }

    public func addAsChild(context: GameScene) {
        context.addChild(self.view)
        (0...model.ballons.count-1).forEach { (index) in
            model.ballons[index].addAsChild(context: self.view)
        }
    }
}

extension CGPoint {
    func byAdding(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + point.x, y: self.y + point.y)
    }
}
