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


func isInMonsterTextureArray(monsterDesc:String, textureArray: [SKTexture]) -> Bool{
    
    for texture in textureArray{
        if monsterDesc == texture.description{
            return true
        }
    }
    
    return false
}



//monster speed up animation
public let monsterSpeedUpTexture_TR = [SKTexture(imageNamed: "enemySpeedUpFrame1_TR"), SKTexture(imageNamed: "enemySpeedUpFrame2_TR"), SKTexture(imageNamed: "enemySpeedUpFrame3_TR"), SKTexture(imageNamed: "enemySpeedUpFrame4_TR"), SKTexture(imageNamed: "enemySpeedUpFrame5_TR"), SKTexture(imageNamed: "enemySpeedUpFrame6_TR"), SKTexture(imageNamed: "enemySpeedUpFrame7_TR"), SKTexture(imageNamed: "enemySpeedUpFrame8_TR"), SKTexture(imageNamed: "enemySpeedUpFrame9_TR"), SKTexture(imageNamed: "enemySpeedUpFrame10_TR"), SKTexture(imageNamed: "enemySpeedUpFrame9_TR"), SKTexture(imageNamed: "enemySpeedUpFrame8_TR"), SKTexture(imageNamed: "enemySpeedUpFrame7_TR"), SKTexture(imageNamed: "enemySpeedUpFrame6_TR"), SKTexture(imageNamed: "enemySpeedUpFrame5_TR"), SKTexture(imageNamed: "enemySpeedUpFrame4_TR"), SKTexture(imageNamed: "enemySpeedUpFrame3_TR"), SKTexture(imageNamed: "enemySpeedUpFrame2_TR"), SKTexture(imageNamed: "enemySpeedUpFrame1_TR")]

public let monsterSpeedUpTexture_TL = [SKTexture(imageNamed: "enemySpeedUpFrame1_TL"), SKTexture(imageNamed: "enemySpeedUpFrame2_TL"), SKTexture(imageNamed: "enemySpeedUpFrame3_TL"), SKTexture(imageNamed: "enemySpeedUpFrame4_TL"), SKTexture(imageNamed: "enemySpeedUpFrame5_TL"), SKTexture(imageNamed: "enemySpeedUpFrame6_TL"), SKTexture(imageNamed: "enemySpeedUpFrame7_TL"), SKTexture(imageNamed: "enemySpeedUpFrame8_TL"), SKTexture(imageNamed: "enemySpeedUpFrame9_TL"), SKTexture(imageNamed: "enemySpeedUpFrame10_TL"), SKTexture(imageNamed: "enemySpeedUpFrame9_TL"), SKTexture(imageNamed: "enemySpeedUpFrame8_TL"), SKTexture(imageNamed: "enemySpeedUpFrame7_TL"), SKTexture(imageNamed: "enemySpeedUpFrame6_TL"), SKTexture(imageNamed: "enemySpeedUpFrame5_TL"), SKTexture(imageNamed: "enemySpeedUpFrame4_TL"), SKTexture(imageNamed: "enemySpeedUpFrame3_TL"), SKTexture(imageNamed: "enemySpeedUpFrame2_TL"), SKTexture(imageNamed: "enemySpeedUpFrame1_TL")]

public let monsterSpeedUpTexture_BL = [SKTexture(imageNamed: "enemySpeedUpFrame1_BL"), SKTexture(imageNamed: "enemySpeedUpFrame2_BL"), SKTexture(imageNamed: "enemySpeedUpFrame3_BL"), SKTexture(imageNamed: "enemySpeedUpFrame4_BL"), SKTexture(imageNamed: "enemySpeedUpFrame5_BL"), SKTexture(imageNamed: "enemySpeedUpFrame6_BL"), SKTexture(imageNamed: "enemySpeedUpFrame7_BL"), SKTexture(imageNamed: "enemySpeedUpFrame8_BL"), SKTexture(imageNamed: "enemySpeedUpFrame9_BL"), SKTexture(imageNamed: "enemySpeedUpFrame10_BL"), SKTexture(imageNamed: "enemySpeedUpFrame9_BL"), SKTexture(imageNamed: "enemySpeedUpFrame8_BL"), SKTexture(imageNamed: "enemySpeedUpFrame7_BL"), SKTexture(imageNamed: "enemySpeedUpFrame6_BL"), SKTexture(imageNamed: "enemySpeedUpFrame5_BL"), SKTexture(imageNamed: "enemySpeedUpFrame4_BL"), SKTexture(imageNamed: "enemySpeedUpFrame3_BL"), SKTexture(imageNamed: "enemySpeedUpFrame2_BL"), SKTexture(imageNamed: "enemySpeedUpFrame1_BL"), ]

public let monsterSpeedUpTexture_BR = [SKTexture(imageNamed: "enemySpeedUpFrame1_BR"), SKTexture(imageNamed: "enemySpeedUpFrame2_BR"), SKTexture(imageNamed: "enemySpeedUpFrame3_BR"), SKTexture(imageNamed: "enemySpeedUpFrame4_BR"), SKTexture(imageNamed: "enemySpeedUpFrame5_BR"), SKTexture(imageNamed: "enemySpeedUpFrame6_BR"), SKTexture(imageNamed: "enemySpeedUpFrame7_BR"), SKTexture(imageNamed: "enemySpeedUpFrame8_BR"), SKTexture(imageNamed: "enemySpeedUpFrame9_BR"), SKTexture(imageNamed: "enemySpeedUpFrame10_BR"), SKTexture(imageNamed: "enemySpeedUpFrame9_BR"), SKTexture(imageNamed: "enemySpeedUpFrame8_BR"), SKTexture(imageNamed: "enemySpeedUpFrame7_BR"), SKTexture(imageNamed: "enemySpeedUpFrame6_BR"), SKTexture(imageNamed: "enemySpeedUpFrame5_BR"), SKTexture(imageNamed: "enemySpeedUpFrame4_BR"), SKTexture(imageNamed: "enemySpeedUpFrame3_BR"), SKTexture(imageNamed: "enemySpeedUpFrame2_BR"), SKTexture(imageNamed: "enemySpeedUpFrame1_BR")]


public let speedUpAnimationTimePerFrame = 0.03
public let monsterSpeedUpAnimation_TR = SKAction.animate(with: monsterSpeedUpTexture_TR, timePerFrame: speedUpAnimationTimePerFrame)
public let monsterSpeedUpAnimation_TL = SKAction.animate(with: monsterSpeedUpTexture_TL, timePerFrame: speedUpAnimationTimePerFrame)
public let monsterSpeedUpAnimation_BL = SKAction.animate(with: monsterSpeedUpTexture_BL, timePerFrame: speedUpAnimationTimePerFrame)
public let monsterSpeedUpAnimation_BR = SKAction.animate(with: monsterSpeedUpTexture_BR, timePerFrame: speedUpAnimationTimePerFrame)


func resetButtonTextures(){
    
    //game
    leaderboardButton.texture = SKTexture(imageNamed: "leaderboardButton")
    shopButton.texture = SKTexture(imageNamed: "shopButtonIcon")
    inventoryButton.texture = SKTexture(imageNamed: "inventoryButton")
    playAgain.texture = SKTexture(imageNamed: "replayButton")
    
    
    //inv
    rightInventoryArrow.texture = SKTexture(imageNamed:"rightArrow")
    leftInventoryArrow.texture = SKTexture(imageNamed:"leftArrow")
    backToGameButton.texture = SKTexture(imageNamed: "backButton")
    
    //shop
    buyButton.texture = SKTexture(imageNamed: "buyButton")
}



