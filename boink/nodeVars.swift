//
//  publicvars.swift
//  dodge2
//
//  Created by Dylan on 8/6/21.
//  Copyright © 2021 S-Crew. All rights reserved.
//
import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit


//screenBounds = UIScreen.main.bounds, screenScale = UIScreen.main.scale, so UIScreen.main.scale = 2x scale
//screen res

public var screenWidth = UIScreen.main.bounds.size.width * CGFloat(2)
public var screenHeight = UIScreen.main.bounds.size.height * CGFloat(2)

//view frame dimension

//public let frameWidth = screenWidth / 2
//public let frameHeight = screenHeight / 2

//borders
public var topBorder = SKShapeNode()
public var bottomBorder = SKShapeNode()
public var leftBorder = SKShapeNode()
public var rightBorder = SKShapeNode()
public var borderBackground = SKSpriteNode()
public let backgroundZPos:CGFloat = -100

public var backgroundPlayArea = SKSpriteNode()
public var backgroundPlayAreaAlphaCover = SKSpriteNode()

//border positions
public  let xPointBorder = screenHeight/10
public let yPointBorder = screenHeight/5

//nodes
public var tempSize = screenHeight/30
public var Player = SKSpriteNode()
public var monsterArray = [SKSpriteNode]()
public var coin = SKSpriteNode()
public let PlayerMonsterMassConstant = 0.0700589120388031



//bit mask
public struct ColliderType{
    static let Player:UInt32 = 1
    static let topBorder:UInt32 = 2
    static let bottomBorder:UInt32 = 4
    static let rightBorder:UInt32 = 8
    static let leftBorder:UInt32 = 16
    static let Monster:UInt32 = 32
    static let coin: UInt32 = 64
    static let MonsterNoCollide: UInt32 = 128
}

//player movement vars
public var goingUp = true
public var goingRight = false
public var playerSpeedConstant = monsterSpeed * 2 * 1.05
public var playerSpeed = playerSpeedConstant
public var playerVelo = CGVector()

//monster
public let monsterSpeedGlitchFix = 14.2737
public var monsterDiameter = Player.size.width
public let monsterSpeedConstant = monsterDiameter / 7.035
//prev div = 6.5
public var monsterSpeed = monsterSpeedConstant


//spawner pos
public var spawner1 = SKSpriteNode()
public var spawner2 = SKSpriteNode()
public var spawner3 = SKSpriteNode()
public var spawner4 = SKSpriteNode()

//info
public var infoButton = SKSpriteNode()
public var gameVersionLabel = SKLabelNode()
public var aboutCreaterLabel = SKLabelNode()
public var aboutHelperLabel = SKLabelNode()
public let infoMenuArr = [menuBox, gameVersionLabel, aboutCreaterLabel, aboutHelperLabel]

//volume
public var volumeButton = SKSpriteNode()








