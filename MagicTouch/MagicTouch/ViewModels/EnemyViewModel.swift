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
        let newPoint = CGPoint(x: Double.random(in: (-1.0...1.0)),
                               y: Double.random(in: (30.0...50.0)))
        self.model.randomInit(
            minBaloon: 0,
            maxBaloon: 10,
            pos: position.byAdding(newPoint)
        )
    }
}

extension CGPoint {
    
    func byAdding(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + point.x, y: self.y + point.y)
    }
}
