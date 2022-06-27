//
//  classes.swift
//  boink
//
//  Created by Dylan Dang on 2/19/22.
//
import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit

// textures, rarity, player or monster?, bought?
public class ObjectSkin : NSObject{
    
    var faceDown: SKTexture
    var topRight: SKTexture
    var topLeft: SKTexture
    var bottomRight: SKTexture
    var bottomLeft: SKTexture
    
    var rarity: Int
    var skinType: Int
    var skinName: String
    
    //FOR textures: 0th face down, 1 TR, 2TL, 3BL, 4BR like quadrants
    init(name: String, textures: [SKTexture], rarity: Int, skinType: Int){
        
        self.skinName = name
        
        self.faceDown = textures[0]
        self.topRight = textures[1]
        self.topLeft = textures[2]
        self.bottomLeft = textures[3]
        self.bottomRight = textures[4]
        
        self.rarity = rarity
        self.skinType = skinType
        
        
        
    }
    
    
    func equip(){
        playerTopRight = topRight
        playerTopLeft = topLeft
        playerBottomLeft = bottomLeft
        playerBottomRight = bottomRight
        playerLookDown = faceDown
    }
    
    
    
    
}
