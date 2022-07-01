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







//dict
public let skinDictionary = [
    //default
    
    "0" : ObjectSkin(name: "Default", textures: skinPackage(name: "default"), rarity: rarityKey.def, skinType: typeKey.player),
    //common
    
    
    "1" : ObjectSkin(name: "NINJA", textures: skinPackage(name: "blueNinja"), rarity: rarityKey.common, skinType: typeKey.player),
    "2": ObjectSkin(name: "FROST", textures: skinPackage(name: "frost"), rarity: rarityKey.common, skinType: typeKey.player),
    "3" : ObjectSkin(name: "PINKY", textures: skinPackage(name: "pinky"), rarity: rarityKey.common, skinType: typeKey.player),
    "4" : ObjectSkin(name: "ALIEN", textures: skinPackage(name: "greenAlien"), rarity: rarityKey.common, skinType: typeKey.player),
    "5" : ObjectSkin(name: "APPA", textures: skinPackage(name: "appa"), rarity: rarityKey.common, skinType: typeKey.player),
    "6" : ObjectSkin(name: "TIGER", textures: skinPackage(name: "tiger"), rarity: rarityKey.common, skinType: typeKey.player),
    //rare
    
    //epic
/*
    "11" : ObjectSkin(name: "epic1", textures: monsterSpawningTextures, rarity: rarityKey.epic, skinType: typeKey.player),
    "12" : ObjectSkin(name: "epic2", textures: monsterSpawningTextures, rarity: rarityKey.epic, skinType: typeKey.player),
    "13" : ObjectSkin(name: "epic3", textures: monsterSpawningTextures, rarity: rarityKey.epic, skinType: typeKey.player),
 */
     
    
    //legendary
]

public struct Skins{
    static let common = keysToStringArray(dKeys: skinDictionary.keys)
    static let epic:[String] = ["11","12","13"]
}

public struct rarityKey{
    static let def = 0
    static let common = 1
    static let rare = 2
    static let epic = 3
    static let legendary = 4
}

public struct typeKey{
    static let player = 1
    static let monster = 2
}



func skinPackage(name: String) -> [SKTexture]{
    return [SKTexture(imageNamed: name), SKTexture(imageNamed: name + "_TR"), SKTexture(imageNamed: name + "_TL"), SKTexture(imageNamed: name + "_BL"), SKTexture(imageNamed: name + "_BR")]
}



//dict keys to string arr
func keysToStringArray(dKeys: Dictionary<String, ObjectSkin>.Keys) -> [String]{
    var a:[String] = []
    for k in dKeys{
        if (k != "0"){
            a.append(k)
        }
    }
    return a
}



//radians to deg
func deg(d:Int)-> CGFloat{
    return CGFloat(Double(d * 180) / M_PI)
}
