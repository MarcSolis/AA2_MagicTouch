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

    public func randomInit(minBaloon: Int, maxBaloon: Int, pos: CGPoint) {

        (0...Int.random(in: minBaloon...maxBaloon)).forEach { (position) in
            self.ballons.append(
                BaloonViewModel(size: CGSize(width: 1, height: 1), position: pos)
            )
        }

    }
}
