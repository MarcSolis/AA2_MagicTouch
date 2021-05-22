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
       
        self.model.randomInit(
            minBaloon: 1,
            maxBaloon: 10,
            enemyPosition: position,
            enemySize: size
        )
    }
    
    public func addAsChild(context: GameScene){
        context.addChild(self.view)
        (0...model.ballons.count-1).forEach { (index) in
            model.ballons[index].addAsChild(context: context)
        }
    }
}

extension CGPoint {
    
    func byAdding(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + point.x, y: self.y + point.y)
    }
}
