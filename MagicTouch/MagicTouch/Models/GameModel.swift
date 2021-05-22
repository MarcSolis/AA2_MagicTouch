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
    
    init(matchTime: Float, screenSize: CGSize){
        self.score = 0
        self.matchTime = matchTime
        self.spawnEnemyPosition = CGPoint(x: 0, y: screenSize.height + 20)
        self.enemyPool = []
    }
    
}
