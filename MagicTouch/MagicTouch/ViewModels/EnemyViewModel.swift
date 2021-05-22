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

    init(size: CGSize, position: CGPoint) {
        self.model = EnemyModel()
        self.view = SKSpriteNode(imageNamed: "Enemy")
        self.view.size = size
        self.view.position = position
        self.view.physicsBody = SKPhysicsBody(circleOfRadius: size.width/4)
        self.view.physicsBody!.affectedByGravity = false
        self.view.physicsBody!.collisionBitMask = 0x00000010
        self.view.physicsBody!.contactTestBitMask = 0x00000000
        self.view.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        self.view.physicsBody!.friction = 0
        self.view.physicsBody!.linearDamping = 0
       
        self.model.randomInit(
            minBaloon: 1,
            maxBaloon: 5,
            enemySize: size
        )
    }
    
    public func reuse(initialPos: CGPoint) {
        self.view.position = CGPoint(x: 0,y: 0)
        self.model.randomInit(minBaloon: 1, maxBaloon: 5, enemySize: self.view.size)
        self.model.active = true
        self.view.physicsBody!.velocity = self.model.movementSpeed
        (0...self.model.ballons.count-1).forEach { (index) in
            self.model.ballons[index].setVelocity(velocity: self.model.movementSpeed)
        }
    }
    
    public func die() {
        self.model.active = false
        self.view.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        (0...self.model.ballons.count-1).forEach { (index) in
            self.model.ballons[index].setVelocity(velocity: CGVector(dx: 0, dy: 0))
        }
    }
    
    public func addAsChild(context: GameScene){
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
