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
        self.view = SKSpriteNode(imageNamed: "Baloon_Pink")
        self.view.size = size
        self.view.position = position
        self.view.physicsBody = SKPhysicsBody(circleOfRadius: size.width/4)
        self.view.physicsBody!.affectedByGravity = false
        self.view.physicsBody!.collisionBitMask = 0x00000001
        self.view.physicsBody!.contactTestBitMask = 0x00000001
    }
    
    public func addAsChild(context: SKSpriteNode){
        context.addChild(self.view)
    }
}
