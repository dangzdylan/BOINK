//
//  coin.swift
//  dodge2
//
//  Created by Dylan on 8/2/21.
//  Copyright © 2021 S-Crew. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit




func addCoinObject(self:SKScene){
    let radius = screenHeight/55
    coin = SKSpriteNode(color: .yellow, size: CGSize(width: radius, height: radius))
    
    coin.texture = SKTexture(imageNamed: "coin")
    
    coin.position = CGPoint(x: screenHeight/14, y: screenHeight/14)
    coin.zPosition = 0
    
    //coin physics
    coin.physicsBody = SKPhysicsBody(circleOfRadius: radius / 2)
    coin.physicsBody?.categoryBitMask = ColliderType.coin
    coin.physicsBody?.contactTestBitMask = ColliderType.Player
    coin.physicsBody?.collisionBitMask = ColliderType.coin
    coin.physicsBody?.isDynamic = false
    coin.physicsBody?.affectedByGravity = false
    
    self.addChild(coin)
}

func touchCoin(self:SKScene){
    addToScore(self:self)
    addToCoinPurse(self: self)
    
    collectCoinAnimaion(self: self, pos: coin.position)
    //move coin to new position
    let distanceW = CGFloat(spawner1.size.width + screenHeight/90)
    let distanceH = CGFloat(spawner1.size.width + screenHeight/90)
    var coinCoord = [CGFloat.random(in: -xPointBorder + distanceW...xPointBorder - distanceW), CGFloat.random(in: -yPointBorder + distanceH...yPointBorder - distanceH)]
    
    while coinDistanceTooClose(x1: coinCoord[0], x2: coin.position.x, y1: coinCoord[1], y2: coin.position.y){
        coinCoord = [CGFloat.random(in: -xPointBorder + distanceW...xPointBorder - distanceW), CGFloat.random(in: -yPointBorder + distanceH...yPointBorder - distanceH)]
    }
    coin.run(SKAction.move(to: CGPoint(x: coinCoord[0], y: coinCoord[1]), duration: 0))
    
    
    //PLAY SOUND
    playSound(soundPlayer: SPKey.collectCoinSoundPlayer)
    
}

func coinDistanceTooClose(x1: CGFloat, x2: CGFloat, y1: CGFloat, y2: CGFloat) -> Bool{
    let xDist = x2 - x1
    let yDist = y2 - y1
    return sqrtf(Float(xDist * xDist + yDist * yDist)) < Float(screenHeight/5)
}


func collectCoinAnimaion(self:SKScene, pos:CGPoint){
    //coin dec
    let coinAnimationNode = SKSpriteNode(color: .blue, size: coin.size)
    coinAnimationNode.position = pos
    coinAnimationNode.texture = coin.texture
    coinAnimationNode.zPosition = backgroundZPos + 1
    
    //label dec
    let coinMultNode = SKLabelNode(text: "+" + String(coinMultiplier))
    coinMultNode.position = CGPoint(x: pos.x + coin.size.width/1.7, y: pos.y + screenHeight/150)
    coinMultNode.fontColor = color(hex: "000000")
    coinMultNode.fontName = currentFont
    coinMultNode.fontSize = coin.size.width/3
    
    //actions
    let action1 = SKAction.move(to: CGPoint(x:pos.x, y: pos.y + screenHeight/30), duration: 0.25)
    let action2 = SKAction.fadeOut(withDuration: action1.duration)
    
    //coin actions
    let coinAction1 = SKAction.move(to: CGPoint(x:coinMultNode.position.x, y: coinMultNode.position.y + screenHeight/30), duration: 0.25)
    let coinAction2 = SKAction.fadeOut(withDuration: 0.15)
    
    //add
    self.addChild(coinAnimationNode)
    self.addChild(coinMultNode)
    
    //play
    coinAnimationNode.run(SKAction.group([action1, action2]))
    coinMultNode.run(SKAction.group([coinAction1, coinAction2]))
    
    
    //remove
    Timer.scheduledTimer(withTimeInterval: action1.duration + action2.duration + 0.2, repeats: false){timer in
        coinAnimationNode.removeFromParent()
        coinMultNode.removeFromParent()
    }
    

}


func addToCoinPurse(self:SKScene){
    if userDefaults.value(forKey: UDKey.coinPurse) != nil{
        if let value = userDefaults.value(forKey: UDKey.coinPurse) as? Int{
            userDefaults.setValue(value + (1 * coinMultiplier), forKey: UDKey.coinPurse)
        }
    
    }else{
        userDefaults.setValue(1, forKey: UDKey.coinPurse)
    }
    

}


