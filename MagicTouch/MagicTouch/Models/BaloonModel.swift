//
//  BaloonModel.swift
//  MagicTouch
//
//  Created by Alumne on 6/5/21.
//

import Foundation
import UIKit

class Baloon {
    let baloonColors = [
        2: UIColor.blue, 5: UIColor.red, 3: UIColor.green, 0: UIColor.yellow, 8: UIColor.purple
    ]
    var movementId: Int!
    var hidden: Bool!
    var number: Int!
    let displayNumberPerID = [2: 5, 5: 2, 3: 3, 0: 0, 8: 8]

    public init(hidden: Bool = false) {
        self.movementId = displayNumberPerID.keys.randomElement()
        self.hidden = hidden
        self.number = displayNumberPerID[self.movementId]
    }
}
