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
    
    "0" : ObjectSkin(name: "Default", textures: skinPackage(name: "default"), rarity: rarityKey.def, skinType: typeKey.player, background: backColor.common),
    //common
    
    "1" : ObjectSkin(name: "NINJA", textures: skinPackage(name: "blueNinja"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "2": ObjectSkin(name: "FROST", textures: skinPackage(name: "frost"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "3" : ObjectSkin(name: "PINKY", textures: skinPackage(name: "pinky"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "4" : ObjectSkin(name: "ALIEN", textures: skinPackage(name: "greenAlien"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "5" : ObjectSkin(name: "BISON", textures: skinPackage(name: "appa"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "6" : ObjectSkin(name: "TIGER", textures: skinPackage(name: "tiger"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "7" : ObjectSkin(name: "MELON", textures: skinPackage(name: "watermelon"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "8" : ObjectSkin(name: "BLU", textures: skinPackage(name: "blueberry"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "9" : ObjectSkin(name: "MONKEY", textures: skinPackage(name: "brownMonkey"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "10" : ObjectSkin(name: "CYCLER", textures: skinPackage(name: "motorcycler"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "11" : ObjectSkin(name: "PURP", textures: skinPackage(name: "purple"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "12" : ObjectSkin(name: "DARK", textures: skinPackage(name: "darkDefault"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "13" : ObjectSkin(name: "PIRATE", textures: skinPackage(name: "pirate"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "14" : ObjectSkin(name: "BALL", textures: skinPackage(name: "greatBall"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "15" : ObjectSkin(name: "BOWLING", textures: skinPackage(name: "galaxyBowlingBall"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "16" : ObjectSkin(name: "SCARFACE", textures: skinPackage(name: "scarBoy"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "17" : ObjectSkin(name: "YOGI", textures: skinPackage(name: "brownBear"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "18" : ObjectSkin(name: "HULK", textures: skinPackage(name: "greenHulk"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "19" : ObjectSkin(name: "MIME", textures: skinPackage(name: "mime"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "20" : ObjectSkin(name: "8-BALL", textures: skinPackage(name: "evil8ball"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "21" : ObjectSkin(name: "EVE", textures: skinPackage(name: "eve"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "22" : ObjectSkin(name: "M&M", textures: skinPackage(name: "greenM&M"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "23" : ObjectSkin(name: "META KNIGHT", textures: skinPackage(name: "metaKnight"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    "24" : ObjectSkin(name: "BURGLAR", textures: skinPackage(name: "burglar"), rarity: rarityKey.common, skinType: typeKey.player, background: backColor.common),
    
    
    
    
    //epic
    "101" : ObjectSkin(name: "GOLD", textures: skinPackage(name: "goldenDefault"), rarity: rarityKey.epic, skinType: typeKey.player, background: backColor.goldenDefault),

     
    
   
]

public struct Skins{
    static let common = comKeysToStringArray(dKeys: skinDictionary.keys)
    static let epic:[String] = ["101"]
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
func comKeysToStringArray(dKeys: Dictionary<String, ObjectSkin>.Keys) -> [String]{
    var a:[String] = []
    for k in dKeys{
        if (skinDictionary[k]!.rarity == rarityKey.common){
            a.append(k)
        }
    }
    return a
}



