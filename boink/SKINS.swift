//
//  SKINS.swift
//  boink
//
//  Created by Dylan Dang on 2/25/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit

func equipSkinAtStart(){
    if userDefaults.value(forKey: UDKey.equippedSkin) != nil{
        let val = userDefaults.value(forKey: UDKey.equippedSkin) as! String
        playerTopRight = skinDictionary[val]!.topRight
        playerTopLeft = skinDictionary[val]!.topLeft
        playerBottomLeft = skinDictionary[val]!.bottomLeft
        playerBottomRight = skinDictionary[val]!.bottomRight
        playerLookDown = skinDictionary[val]!.faceDown
    }else{
        userDefaults.setValue("0", forKey: UDKey.equippedSkin)
    }
}


