//
//  CGFloat+.swift
//  MagicTouch
//
//  Created by Alumne on 3/6/21.
//

import Foundation
import UIKit

extension CGVector {
    static func sum(value1: CGVector, value2: CGVector ) -> CGVector {
        return CGVector(dx: value1.dx + value2.dx, dy: value1.dy + value2.dy)
    }
}
