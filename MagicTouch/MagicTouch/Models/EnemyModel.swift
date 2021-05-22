//
//  EnemyModel.swift
//  MagicTouch
//
//  Created by Alumne on 6/5/21.
//

import Foundation
import UIKit

class EnemyModel {
    var ballons = [BaloonViewModel]()
    var skinId: Int
    var points: Int
    var active: Bool
    let movementSpeed: CGVector

    init() {
        skinId = 0
        points = 0
        ballons = []
        active = false
        movementSpeed = CGVector(dx: 0, dy: -80)
    }

    public func randomInit(minBaloon: Int, maxBaloon: Int, enemySize: CGSize) {

        (0...Int.random(in: minBaloon...maxBaloon)).forEach { (position) in
            let newPoint = CGPoint(x: Double.random(in: (-30.0...30.0)),
                                   y: Double.random(in: (40...60.0)))
            self.ballons.append(
                BaloonViewModel(size: CGSize(width: 0.5*enemySize.width, height: 0.5*enemySize.height), position: newPoint)
            )
        }

    }
}
