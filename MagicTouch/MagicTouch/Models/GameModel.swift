//
//  GameModel.swift
//  MagicTouch
//
//  Created by Alumne on 6/5/21.
//

import Foundation
import GameKit


struct GameModel {
    var score: Int
    var matchTime: Float
    let spawnEnemyPosition: CGPoint
    var enemyPool: [EnemyViewModel]!
    let enemyPoolSize = 15
    let background = SKSpriteNode(imageNamed: "Background")
    let castle = SKSpriteNode(imageNamed: "Castle")
    let ground = SKSpriteNode(imageNamed: "Ground")
    
    init(matchTime: Float, screenSize: CGSize, context: GameScene){
        self.score = 0
        self.matchTime = matchTime
        self.spawnEnemyPosition = CGPoint(x: 0, y: screenSize.height/2 - 20)
        self.enemyPool = []

        self.background.size = screenSize
        self.background.position = CGPoint(x: 0, y: 0)
        self.background.zPosition = 1

        self.castle.size = CGSize(width: screenSize.width, height: screenSize.width/1.5)
        self.castle.anchorPoint = CGPoint(x:0.5, y:0)
        self.castle.position = CGPoint(x: 0, y: -screenSize.height/2+80)
        self.castle.zPosition = 2

        self.ground.size = CGSize(width: screenSize.width, height: screenSize.width/9)
        self.ground.anchorPoint = CGPoint(x:0.5, y:0)
        self.ground.position = CGPoint(x: 0, y: -screenSize.height/2+80)
        self.ground.zPosition = 3
        self.ground.physicsBody = SKPhysicsBody(rectangleOf: self.ground.size)
        self.ground.physicsBody!.affectedByGravity = false
        self.ground.physicsBody!.isDynamic = false
        self.ground.physicsBody!.collisionBitMask = 0x00000100

        
        context.addChild(self.castle)
        context.addChild(self.background)
        context.addChild(self.ground)
    }
    
}
