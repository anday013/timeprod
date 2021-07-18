//
//  SizeHelper.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import Foundation
import SwiftUI


class Size {
    static func computeWidth(_ size: CGFloat) -> CGFloat{
        return UIScreen.main.bounds.width * size / 375
    }
    
    static func computeHeight(_ size: CGFloat) -> CGFloat{
        return UIScreen.main.bounds.height * size / 812
    }
}
