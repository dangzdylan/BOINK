//
//  borders.swift
//  dodge2
//
//  Created by Dylan on 8/1/21.
//  Copyright © 2021 S-Crew. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit


func addBorders(self:GameScene){
    //border points
    
    
    var topPoints = [CGPoint(x: -xPointBorder, y:yPointBorder),
                    CGPoint(x: xPointBorder, y:yPointBorder)]
    var rightPoints = [CGPoint(x:xPointBorder, y:yPointBorder),
                    CGPoint(x: xPointBorder, y: -yPointBorder)]
    var bottomPoints = [CGPoint(x: xPointBorder, y: -yPointBorder),
                    CGPoint(x: -xPointBorder, y: -yPointBorder)]
    var leftPoints = [CGPoint(x: -xPointBorder, y: -yPointBorder),
                    CGPoint(x: -xPointBorder, y:yPointBorder)]
    
    

    //borders dec
    leftBorder = SKShapeNode(points: &leftPoints, count: leftPoints.count)
    rightBorder = SKShapeNode(points: &rightPoints, count: rightPoints.count)
    topBorder = SKShapeNode(points: &topPoints, count: topPoints.count)
    bottomBorder = SKShapeNode(points: &bottomPoints, count: bottomPoints.count)
    


    //physics body

    leftBorder.physicsBody = SKPhysicsBody(edgeChainFrom: leftBorder.path!)
    rightBorder.physicsBody = SKPhysicsBody(edgeChainFrom: rightBorder.path!)
    topBorder.physicsBody = SKPhysicsBody(edgeChainFrom: topBorder.path!)
    bottomBorder.physicsBody = SKPhysicsBody(edgeChainFrom: bottomBorder.path!)
    
    topBorder.physicsBody?.categoryBitMask = ColliderType.topBorder
    bottomBorder.physicsBody?.categoryBitMask = ColliderType.bottomBorder
    rightBorder.physicsBody?.categoryBitMask = ColliderType.rightBorder
    leftBorder.physicsBody?.categoryBitMask = ColliderType.leftBorder

    let borderArr = [leftBorder, rightBorder, topBorder, bottomBorder]
    for borderBody in borderArr{
        
        borderBody.physicsBody?.contactTestBitMask = borderBody.physicsBody!.categoryBitMask
        borderBody.strokeColor = textBorderColor
        borderBody.physicsBody?.friction = 0
        borderBody.physicsBody?.restitution = 1
        borderBody.physicsBody?.angularDamping = 0
        borderBody.physicsBody?.linearDamping = 0
        borderBody.physicsBody?.affectedByGravity = false
        borderBody.physicsBody?.isDynamic = false
    
        
        self.addChild(borderBody)
        
    }
 
    
    
    //border background
    borderBackground = SKSpriteNode(color: .white, size: CGSize(width: xPointBorder * 2, height: yPointBorder * 2))
    borderBackground.position = CGPoint(x: 0, y: 0)
    borderBackground.zPosition = backgroundZPos
    borderBackground.physicsBody?.collisionBitMask = 0
    borderBackground.physicsBody?.contactTestBitMask = 0
    
    self.addChild(borderBackground)
    
    
}
  
    

