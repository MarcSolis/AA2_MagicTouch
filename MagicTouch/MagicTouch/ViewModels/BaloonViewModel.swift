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

    init(size: CGSize, position: CGPoint) {
        self.model = Baloon(identifer: Int.random(in: 0...4))
        self.view = SKSpriteNode(imageNamed: "Baloon")
        self.view.isUserInteractionEnabled = false
        self.view.size = size
        self.view.position = position
        self.view.color = self.model.baloonColors[self.model.movementId]
        self.view.colorBlendFactor = 1
        self.view.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.view.physicsBody!.affectedByGravity = false
        self.view.physicsBody!.collisionBitMask = 0x00000001
        self.view.physicsBody!.contactTestBitMask = 0x00000001
        self.view.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        self.view.physicsBody!.friction = 0
        self.view.physicsBody!.linearDamping = 0
        self.view.isHidden = true
    }

    public func setVelocity(velocity: CGVector) {
        self.view.physicsBody!.velocity = velocity
    }

    public func addAsChild(context: SKSpriteNode) {
        context.addChild(self.view)
    }

    public func reuse() {
        self.view.isHidden = false
        self.model.movementId = Int.random(in: 0...4)
        self.view.color = self.model.baloonColors[self.model.movementId]

        let newPoint = CGPoint(x: Double.random(in: (-30.0...30.0)),
                               y: Double.random(in: (40...60.0)))
        self.view.position = newPoint
    }
}
