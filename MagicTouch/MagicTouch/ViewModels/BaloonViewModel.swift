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
    }
}
