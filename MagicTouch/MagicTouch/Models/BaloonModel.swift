//
//  BaloonModel.swift
//  MagicTouch
//
//  Created by Alumne on 6/5/21.
//

import Foundation
import UIKit


class Baloon {
    let baloonColors: [UIColor] = [
        UIColor.blue, UIColor.red, UIColor.green, UIColor.yellow, UIColor.purple
    ]
    var movementId: Int!
    var hidden: Bool!

    public init(id: Int, hidden: Bool = false) {
        self.movementId = id
        self.hidden = hidden
    }
}
