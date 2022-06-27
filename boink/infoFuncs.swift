//
//  about.swift
//  boink
//
//  Created by Dylan Dang on 12/31/21.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit

func addInfoButton(self:SKScene){
    
    let diameter = screenHeight/57
    infoButton = SKSpriteNode(color: .blue, size: CGSize(width: diameter, height: diameter))
    infoButton.position = CGPoint(x: screenWidth/4 - screenWidth/40, y: -screenHeight/4 + screenHeight/50)
    infoButton.texture = SKTexture(imageNamed: "infoButton")
    
    self.addChild(infoButton)
}

func addInfoMenu(self:SKScene){
    
    infoMenuActive = true
    makeMenuBox(self: self, pos:CGPoint(x: 0, y: 0))
    
    gameVersionLabel = SKLabelNode(text: "BOINK!  VERSION 1.2.0")
    gameVersionLabel.fontColor = .white
    gameVersionLabel.fontName = currentFont
    gameVersionLabel.fontSize = screenHeight/90
    gameVersionLabel.position = CGPoint(x: menuBox.position.x, y: menuBox.position.y + screenHeight/30)
    gameVersionLabel.zPosition = menuBox.zPosition + 1
    
    aboutCreaterLabel = SKLabelNode(text:"APP BY DYLAN DANG")
    aboutCreaterLabel.fontColor = .white
    aboutCreaterLabel.fontName = currentFont
    aboutCreaterLabel.fontSize = screenHeight/95
    aboutCreaterLabel.position = menuBox.position
    aboutCreaterLabel.zPosition = menuBox.zPosition + 1
    
    aboutHelperLabel = SKLabelNode(text:"**GRAPHICS BY GIAN DAVID**")
    aboutHelperLabel.fontColor = .white
    aboutHelperLabel.fontName = currentFont
    aboutHelperLabel.fontSize = screenHeight/120
    aboutHelperLabel.position = CGPoint(x: menuBox.position.x, y: menuBox.position.y - screenHeight/30)
    aboutHelperLabel.zPosition = menuBox.zPosition + 1
    
    
    for ele in infoMenuArr{
        self.addChild(ele)
    }

    infoButton.removeFromParent()
    volumeButton.removeFromParent()
    
}


func infoMenuExit(self:SKScene){
    
    for ele in infoMenuArr{
        ele.removeFromParent()
    }
    infoMenuActive = false
    
    self.addChild(infoButton)
    self.addChild(volumeButton)
    
    
}
