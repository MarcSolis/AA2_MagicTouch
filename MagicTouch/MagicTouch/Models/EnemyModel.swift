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

    init() {
        skinId = 0
        points = 0
        ballons = []
    }

    public func randomInit(minBaloon: Int, maxBaloon: Int, enemyPosition: CGPoint, enemySize: CGSize) {

        (0...Int.random(in: minBaloon...maxBaloon)).forEach { (position) in
            let newPoint = CGPoint(x: Double.random(in: (-30.0...30.0)),
                                   y: Double.random(in: (40...60.0)))
            self.ballons.append(
                BaloonViewModel(size: CGSize(width: 1*enemySize.width, height: 1*enemySize.height), position: enemyPosition.byAdding(newPoint))
            )
        }

    }
}
