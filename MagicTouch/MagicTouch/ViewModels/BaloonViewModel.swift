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
        self.model = Baloon(id: 0)
        self.view = SKSpriteNode(imageNamed: "Baloon")
        self.view.size = size
        self.view.position = position
        self.view.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.view.physicsBody!.affectedByGravity = false
        self.view.physicsBody!.collisionBitMask = 0x00000001
        self.view.physicsBody!.contactTestBitMask = 0x00000001
        self.view.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        self.view.physicsBody!.friction = 0
        self.view.physicsBody!.linearDamping = 0
    }
    
    public func setVelocity(velocity: CGVector){
        self.view.physicsBody!.velocity = velocity
    }
    
    public func addAsChild(context: SKSpriteNode){
        context.addChild(self.view)
    }
}
