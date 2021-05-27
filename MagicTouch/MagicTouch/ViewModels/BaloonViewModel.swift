//
//  BaloonViewModel.swift
//  MagicTouch
//
//  Created by Alumne on 18/5/21.
//

import SpriteKit
import Foundation

class BaloonViewModel {
    var model: Baloon
    var view: SKSpriteNode
    var displayNumber: SKLabelNode!

    init(size: CGSize, position: CGPoint) {
        self.model = Baloon()
        self.view = SKSpriteNode(imageNamed: "Baloon")
        self.view.isUserInteractionEnabled = false
        self.view.size = size
        self.view.position = position
        self.view.color = self.model.baloonColors[self.model.movementId]!
        self.view.colorBlendFactor = 1
        self.view.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.view.physicsBody!.affectedByGravity = false
        self.view.physicsBody!.collisionBitMask = 0x00000001
        self.view.physicsBody!.contactTestBitMask = 0x00000001
        self.view.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        self.view.physicsBody!.friction = 0
        self.view.physicsBody!.linearDamping = 0
        self.view.isHidden = true
        
        self.displayNumber = SKLabelNode(text: String(self.model.number))
        self.displayNumber.zPosition = self.view.zPosition + CGFloat(1)
        self.view.addChild(displayNumber)
    }

    public func setVelocity(velocity: CGVector) {
        self.view.physicsBody!.velocity = velocity
    }

    public func addAsChild(context: SKSpriteNode) {
        context.addChild(self.view)
    }

    public func reuse() {
        self.view.isHidden = false
        self.model.movementId = self.model.displayNumberPerID.keys.randomElement()
        self.view.color = self.model.baloonColors[self.model.movementId]!
        self.model.number = self.model.displayNumberPerID[self.model.movementId]
        self.displayNumber.removeFromParent()
        
        self.displayNumber = SKLabelNode(text: String(self.model.number))
        self.displayNumber.zPosition = self.view.zPosition + CGFloat(1)
        self.view.addChild(displayNumber)
        
        let newPoint = CGPoint(x: Double.random(in: (-30.0...30.0)),
                               y: Double.random(in: (40...60.0)))
        self.view.position = newPoint
    }
}
