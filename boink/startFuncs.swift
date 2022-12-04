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

func hideStartLabels(){
    //hide labels
    score.isHidden = false
    tapToLabel.isHidden = true
    startLabel.isHidden = true
    
    //remove
    tutorialImage.removeFromParent()
    titleLabel.removeFromParent()
    infoButton.removeFromParent()
    volumeButton.removeFromParent()
    leaderboardButton.removeFromParent()
    shopButton.removeFromParent()
    inventoryButton.removeFromParent()
    displayedCoinPurse.removeFromParent()
    coinImageNode.removeFromParent()
}


func startGame(self:SKScene){
    
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
    
    var d:Double = 0
    if replayButtonHasBeenClicked{
        d = 0.5
    }
    Timer.scheduledTimer(withTimeInterval: d, repeats: false){timer in
        spawnMonster(self: self)
    }
    
    //hide highscore
    highScoreWordLabel.isHidden = true

}


func addTitleLabel(self:SKScene){
    
    
    titleLabel = SKLabelNode(text: "BOINK!")
    
    titleLabel.fontName = currentFont
    titleLabel.fontColor = color(hex:"8D8A8C")
    titleLabel.fontSize = screenHeight/20
    titleLabel.position = CGPoint(x: 0, y: menuBoxY)
    
    self.addChild(titleLabel)
    
    let endHeight = screenHeight/8.5
    //time1
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false){timer in
        
        
        let move1 = SKAction.move(to: CGPoint(x:0, y:endHeight), duration: 0.7)
        let move2 = SKAction.run {
            //playSound(soundPlayer: SPKey.titleStompSoundPlayer)
        }
        let move3 = SKAction.move(to: CGPoint(x:0, y:endHeight + screenHeight/50), duration: 0.2)
        move3.timingMode = .easeOut
        let move4 = SKAction.move(to: CGPoint(x:0, y:endHeight), duration: 0.08)
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
    
    tapToLabel.fontSize = screenHeight/33
    startLabel.fontSize = screenHeight/33
    
    tapToLabel.position = CGPoint(x: 0, y: screenHeight/16)
    startLabel.position = CGPoint(x: 0, y: -screenHeight/10.5)
    
    
    tapToLabel.fontColor = color(hex:"CDCACC")
    startLabel.fontColor = color(hex:"CDCACC")
    
    //add to scene
    self.addChild(tapToLabel)
    self.addChild(startLabel)
}


func callStartFuncs(self:SKScene){
    
    startGame(self: self)
    movePlayer(self:self)
    
    subtractGameCount()
    replayButtonHasBeenClicked = false
}


func playPlayerShrinkAnimation(self:SKScene){
    //vars
    playerShrinkAnimationActive = true
    gameHasStarted = true
    hideStartLabels()
    
    //dec actions
    let shrink = SKAction.resize(toWidth: monsterDiameter, height: monsterDiameter, duration: 0.6)
    shrink.timingMode = .easeIn
    
    let start = SKAction.run {
        callStartFuncs(self: self)
        playerShrinkAnimationActive = false
    }
    
    //sound
    var t:Double = 0
    if replayButtonHasBeenClicked{
        t = 0.75
    }
    Timer.scheduledTimer(withTimeInterval: t, repeats: false){timer in
        playSound(soundPlayer: SPKey.playerShrink)
    }
    
    //animation then start
    Player.run(SKAction.sequence([shrink, start]))
    
    
    
    
}



func addTutorialImage(self:SKScene){
    
    //init game play count
    if userDefaults.value(forKey: UDKey.numberOfGamesPlayed) == nil {
        userDefaults.setValue(3, forKey: UDKey.numberOfGamesPlayed)
    }
    
    
    //dec nodes
    tutorialImage = SKSpriteNode(color: .blue, size: CGSize(width: screenHeight/30, height: screenHeight/15))
    tutorialImage.position = CGPoint(x: screenHeight/14, y:-screenHeight/45)
    
    tutorialImage.texture = SKTexture(imageNamed: "tutorialImage")
    
    //dec actions
    let arr = TutorialFramesArray()
    let ani = SKAction.animate(with: arr, timePerFrame: 1/30)
    
    let wait = SKAction.wait(forDuration: 2)
    tutorialImage.run(SKAction.repeatForever(SKAction.sequence([ani,wait])))
    
    //add
    if userDefaults.value(forKey: UDKey.numberOfGamesPlayed) as! Int > 0{
        self.addChild(tutorialImage)
    }
}

func TutorialFramesArray() -> [SKTexture]{
    var arr:[SKTexture] = []
    
    for i in 1...64{
        arr.append(SKTexture(imageNamed: "tutorialImageFrame" + String(i)))
    }
    
    return arr
    
}

func subtractGameCount(){
    
    let val = (userDefaults.value(forKey: UDKey.numberOfGamesPlayed) as! Int) - 1
    let a = max(val, 0)
    
    
    userDefaults.setValue(a, forKey: UDKey.numberOfGamesPlayed)
    
}
