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



public let mysterySkinPrice = 250

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
public var inventoryButton = SKSpriteNode()


public let shopBackgroundColor = color(hex: "B8F6C4")

public var currentUnboxedSkinInd = "0"
public var currentUnboxedSkin = skinDictionary[currentUnboxedSkinInd]!





