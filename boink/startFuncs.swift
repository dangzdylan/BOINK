//
//  startpage.swift
//  dodge2
//
//  Created by Dylan on 8/9/21.
//  Copyright © 2021 S-Crew. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit

func addStartLabels(self: SKScene){
    
    addTapToStartLabels(self: self)
    addTitleLabel(self: self)
    
    
}


func startGame(self:SKScene){
    
    //hide labels
    score.isHidden = false
    tapToLabel.isHidden = true
    startLabel.isHidden = true
    
    //remove
    titleLabel.removeFromParent()
    infoButton.removeFromParent()
    volumeButton.removeFromParent()
    leaderboardButton.removeFromParent()
    shopButton.removeFromParent()
    inventoryButton.removeFromParent()
    
    
    //set direction
    goingRight = false
    goingUp = true
    
    //set gamestate
    gameHasStarted = true
    gameHasEnded = false
    
    //reset spawn monster ind
    spawnArrInd = 0
    
    //call funcs
    addScoreLabel(self: self)
    spawnMonster(self: self)
    
    //hide highscore
    highScoreWordLabel.isHidden = true

}


func addTitleLabel(self:SKScene){
    
    
    titleLabel = SKLabelNode(text: "BOINK!")
    
    titleLabel.fontName = currentFont
    titleLabel.fontColor = color(hex:"8D8A8C")
    titleLabel.fontSize = screenHeight/22
    titleLabel.position = CGPoint(x: 0, y: menuBoxY)
    
    self.addChild(titleLabel)
    
    //time1
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false){timer in
        
        
        let move1 = SKAction.move(to: CGPoint(x:0, y:screenHeight/10), duration: 0.7)
        let move2 = SKAction.run {
            //playSound(soundPlayer: SPKey.titleStompSoundPlayer)
        }
        let move3 = SKAction.move(to: CGPoint(x:0, y:screenHeight/10 + screenHeight/50), duration: 0.2)
        move3.timingMode = .easeOut
        let move4 = SKAction.move(to: CGPoint(x:0, y:screenHeight/10), duration: 0.08)
        move4.timingMode = .easeIn
        
        let moveGroup1 = SKAction.group([move1, move2])
        let moveGroup2 = SKAction.sequence([moveGroup1, move3, move4])
        titleLabel.run(moveGroup2)
    }
        
       
    
    //time2, just in case
    Timer.scheduledTimer(withTimeInterval: 2, repeats: false){timer in
        titleLabelAnimationFinished = true
        }
    
    }



func addTapToStartLabels(self:SKScene){
    //dec
    tapToLabel = SKLabelNode(text: "TAP TO")
    startLabel = SKLabelNode(text: "START")
    
    //attributes
    
    tapToLabel.fontName = currentFont
    startLabel.fontName = currentFont
    
    tapToLabel.fontSize = screenHeight/35
    startLabel.fontSize = screenHeight/35
    
    tapToLabel.position = CGPoint(x: 0, y: screenHeight/24)
    startLabel.position = CGPoint(x: 0, y: -screenHeight/16)
    
    
    tapToLabel.fontColor = color(hex:"CDCACC")
    startLabel.fontColor = color(hex:"CDCACC")
    
    //add to scene
    self.addChild(tapToLabel)
    self.addChild(startLabel)
}
