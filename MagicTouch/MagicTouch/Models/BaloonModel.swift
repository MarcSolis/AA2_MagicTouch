//
//  BaloonModel.swift
//  MagicTouch
//
//  Created by Alumne on 6/5/21.
//

import Foundation
import UIKit

class Baloon {
    var color: UIColor!
    var movementId: Int!
    var hidden: Bool!

    public init(id: Int, hidden: Bool = false) {
        self.color = UIColor(red: CGFloat(id), green: CGFloat(id), blue: CGFloat(id), alpha: CGFloat(id))
        self.movementId = id
        self.hidden = hidden
    }
}
