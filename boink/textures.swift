//
//  textures.swift
//  boink
//
//  Created by Dylan Dang on 8/22/21.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit


//monster
public var monsterBottomLeft = SKTexture(imageNamed: "enemy_BL")
public var monsterBottomRight = SKTexture(imageNamed: "enemy_BR")
public var monsterTopLeft = SKTexture(imageNamed: "enemy_TL")
public var monsterTopRight = SKTexture(imageNamed: "enemy_TR")

//player
public var playerTopRight = SKTexture(imageNamed: "default_TR")
public var playerTopLeft = SKTexture(imageNamed: "default_TL")
public var playerBottomLeft = SKTexture(imageNamed: "default_BL")
public var playerBottomRight = SKTexture(imageNamed: "default_BR")
public var playerLookDown = SKTexture(imageNamed: "default")

public let deadPlayerTextureArr = [SKTexture(imageNamed: "deadPlayer_TR"), SKTexture(imageNamed: "deadPlayer_TL"), SKTexture(imageNamed: "deadPlayer_BL"), SKTexture(imageNamed: "deadPlayer_BR")]


//monster move animation
public let monsterSpawningTextures = [SKTexture(imageNamed: "enemySpawning1"),SKTexture(imageNamed: "enemySpawning2"),SKTexture(imageNamed: "enemySpawning3"),SKTexture(imageNamed: "enemySpawning4"),SKTexture(imageNamed: "enemySpawning5"),SKTexture(imageNamed: "enemySpawning6"),SKTexture(imageNamed: "enemySpawning7"),SKTexture(imageNamed: "enemySpawning8"), SKTexture(imageNamed: "enemySpawn")]

public let monsterTextures_TR = [SKTexture(imageNamed: "enemyFrame1_TR"), SKTexture(imageNamed: "enemyFrame2_TR"), SKTexture(imageNamed: "enemyFrame3_TR"), SKTexture(imageNamed: "enemyFrame4_TR"), SKTexture(imageNamed: "enemyFrame5_TR")]

public let monsterTextures_TL = [SKTexture(imageNamed: "enemyFrame1_TL"), SKTexture(imageNamed: "enemyFrame2_TL"), SKTexture(imageNamed: "enemyFrame3_TL"), SKTexture(imageNamed: "enemyFrame4_TL"), SKTexture(imageNamed: "enemyFrame5_TL")]

public let monsterTextures_BL = [SKTexture(imageNamed: "enemyFrame1_BL"), SKTexture(imageNamed: "enemyFrame2_BL"), SKTexture(imageNamed: "enemyFrame3_BL"), SKTexture(imageNamed: "enemyFrame4_BL"), SKTexture(imageNamed: "enemyFrame5_BL")]

public let monsterTextures_BR = [SKTexture(imageNamed: "enemyFrame1_BR"), SKTexture(imageNamed: "enemyFrame2_BR"), SKTexture(imageNamed: "enemyFrame3_BR"), SKTexture(imageNamed: "enemyFrame4_BR"), SKTexture(imageNamed: "enemyFrame5_BR")]



public let monsterAnimation_TR = SKAction.animate(with: monsterTextures_TR, timePerFrame: 0.1)
public let monsterAnimation_TL = SKAction.animate(with: monsterTextures_TL, timePerFrame: 0.1)
public let monsterAnimation_BL = SKAction.animate(with: monsterTextures_BL, timePerFrame: 0.1)
public let monsterAnimation_BR = SKAction.animate(with: monsterTextures_BR, timePerFrame: 0.1)


func resetButtonTextures(){
    
    //game
    leaderboardButton.texture = SKTexture(imageNamed: "leaderboardButton")
    shopButton.texture = SKTexture(imageNamed: "shopButtonIcon")
    inventoryButton.texture = SKTexture(imageNamed: "inventoryButton")
    playAgain.texture = SKTexture(imageNamed: "replayButton")
    backToHomeButton.texture = SKTexture(imageNamed: "menuHomeButton")
    
    
    //inv
    rightInventoryArrow.texture = SKTexture(imageNamed:"rightArrow")
    leftInventoryArrow.texture = SKTexture(imageNamed:"leftArrow")
    backToGameButton.texture = SKTexture(imageNamed: "backButton")
    
    //shop
    buyButton.texture = SKTexture(imageNamed: "buyButton")
}



