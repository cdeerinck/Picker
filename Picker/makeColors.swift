//
//  makeColors.swift
//  Picker
//
//  Created by Chuck Deerinck on 6/21/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

func makeColors() {
    for i in 0...7 {
        let iFloat = CGFloat(i)
        sDarkColor[i] = UIColor(hue: iFloat/7, saturation: 1, brightness: 0.5, alpha: 1)
        sLightColor[(i+4)%8] = UIColor(hue: iFloat/7, saturation: 0.6, brightness: 1, alpha: 1)
        tDarkColor[i] = UIColor(hue: iFloat/7, saturation: 1, brightness: 0.5, alpha: 0.4)
        tLightColor[(i+4)%8] = UIColor(hue: iFloat/7, saturation: 1, brightness: 1, alpha: 0.4)
    }
}
