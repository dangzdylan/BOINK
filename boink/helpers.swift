//
//  helpers.swift
//  boink
//
//  Created by Dylan Dang on 12/4/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit



func intLength(num:Int)-> Int{
    var count = 1;
    var n = num;
    while (n >= 10){
        n /= 10
        count += 1
    }
    
    return count
}
