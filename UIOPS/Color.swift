//
//  Color.swift
//  UIOPS
//
//  Created by younke on 20.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import UIKit

extension UIColor {

    static var random: UIColor {
        let rand = { CGFloat.random(in: 0...1) }
        return UIColor(red: rand(), green: rand(), blue: rand(), alpha: 1.0)
    }
}
