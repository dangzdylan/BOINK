//
//  shopVars.swift
//  boink
//
//  Created by Dylan Dang on 2/19/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit



public let mysterySkinPrice = 0

public var shopButton = SKSpriteNode()
public var backToGameButton = SKSpriteNode()
public var displayedCoinPurse = SKLabelNode()
public var coinMultiplier = 1
public var buyButton = SKSpriteNode()
public var buyButtonAnimationActive = false

public var comingSoonBox = SKSpriteNode()


public var crateImage = SKSpriteNode()
public var crateImage2 = SKSpriteNode()
public let crateImageZPosition:CGFloat = 50

public let objectSkinsArr:[ObjectSkin] = []

let defaultSkinArr = [SKTexture(imageNamed: "default"), SKTexture(imageNamed: "default_TR"), SKTexture(imageNamed: "default_TL"), SKTexture(imageNamed: "default_BL"), SKTexture(imageNamed: "default_BR")]

public let skinDictionary = [
    //default
    
    "0" : ObjectSkin(name: "default", textures: defaultSkinArr, rarity: rarityKey.def, skinType: typeKey.player),
    //common
    
    
    "1" : ObjectSkin(name: "common1", textures: monsterSpawningTextures, rarity: rarityKey.common, skinType: typeKey.player),
    "2": ObjectSkin(name: "common2", textures: monsterSpawningTextures, rarity: rarityKey.common, skinType: typeKey.player),
    "3" : ObjectSkin(name: "common3", textures: monsterSpawningTextures, rarity: rarityKey.common, skinType: typeKey.player),
    "4" : ObjectSkin(name: "common4", textures: monsterSpawningTextures, rarity: rarityKey.common, skinType: typeKey.player),
    "5" : ObjectSkin(name: "common5", textures: monsterSpawningTextures, rarity: rarityKey.common, skinType: typeKey.player),
    "6" : ObjectSkin(name: "common1", textures: monsterSpawningTextures, rarity: rarityKey.common, skinType: typeKey.player),
    "7": ObjectSkin(name: "common2", textures: monsterSpawningTextures, rarity: rarityKey.common, skinType: typeKey.player),
    "8" : ObjectSkin(name: "common3", textures: monsterSpawningTextures, rarity: rarityKey.common, skinType: typeKey.player),
    "9" : ObjectSkin(name: "common4", textures: monsterSpawningTextures, rarity: rarityKey.common, skinType: typeKey.player),
    "10" : ObjectSkin(name: "common5", textures: monsterSpawningTextures, rarity: rarityKey.common, skinType: typeKey.player),
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
    static let common:[String] = ["1","2","3","4","5","6","7","8","9","10"]
    static let epic:[String] = ["11","12","13"]
}

public var inventoryButton = SKSpriteNode()


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
