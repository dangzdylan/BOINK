//
//  endLabels.swift
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



func gameOver(self:SKScene){
    
    //hide and reset vars
    coinMultiplier = 1
    stopPlayerTextureMove = false
    score.isHidden = true
    monsterSpeed = monsterSpeedConstant
    playerSpeed = playerSpeedConstant
    monsterArray = []
    
    //func calls
    updateHighScore(self: self)
    gameOverMenu(self:self)

}


func gameOverAnimation(self: SKScene){
    stopPlayerTextureMove = true
    playSound(soundPlayer: SPKey.gameOverSoundPlayer)
    gameHasEnded = true
    for monster in monsterArray{
        monster.physicsBody?.isDynamic = false
    }
    Player.physicsBody?.isDynamic = false
    
    
    
    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false){timer in
        Player.colorBlendFactor = 0.875
        //Player.texture = deadPlayerTexture()
    }
     
    
    Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){timer in
        let movePlayer = SKAction.move(to: CGPoint(x: Player.position.x, y: -screenHeight), duration: 2)
        Player.run(movePlayer)
    }
     
}


func gameOverMenu(self:SKScene){
    
    let boxZPos:CGFloat = 100
    
    makeMenuBox(self: self, pos:CGPoint(x: 0, y: menuBoxY))
    
    
    //put in score and play again button
    let margins = screenHeight/100

    //play again button
    playAgain = SKSpriteNode(color:.white, size: CGSize(width:menuBox.size.height / 3 , height: menuBox.size.height / 3))
    playAgain.position = CGPoint(x: menuBox.position.x + playAgain.size.width/1.7, y: menuBox.position.y - playAgain.size.height + margins)
    playAgain.zPosition = boxZPos + 1
    playAgain.texture = SKTexture(imageNamed: "replayButton")
    playAgainButtonActive = true
    
    //back to home
    backToHomeButton = SKSpriteNode(color: .purple, size: playAgain.size)
    backToHomeButton.position = CGPoint(x: menuBox.position.x - backToHomeButton.size.width/1.7, y: playAgain.position.y)
    backToHomeButton.zPosition = playAgain.zPosition
    backToHomeButton.texture = SKTexture(imageNamed: "menuHomeButton")
    
         
    //word score
    scoreWordLabel = SKLabelNode(text: "SCORE:")
    scoreWordLabel.fontName = currentFont
    scoreWordLabel.fontSize = screenHeight/40
    scoreWordLabel.position = CGPoint(x: menuBox.position.x, y: menuBox.position.y + menuBox.size.height/2 - margins - scoreWordLabel.fontSize)
    scoreWordLabel.zPosition = boxZPos + 1
    
    //the actual score
    scoreNumberLabel = SKLabelNode(text: score.text)
    scoreNumberLabel.fontName = currentFont
    scoreNumberLabel.fontSize = screenHeight/16
    scoreNumberLabel.position = CGPoint(x:menuBox.position.x, y: menuBox.position.y)
    scoreNumberLabel.zPosition = boxZPos + 1
    
    
    //run action
    let boxArr = [menuBox, playAgain, scoreWordLabel, scoreNumberLabel, backToHomeButton]

    menuEnter(self: self, boxArr: boxArr)

    
}
func menuEnter(self:SKScene, boxArr:[SKNode]){
    
    for sprite in boxArr{
        self.addChild(sprite)
        let spriteMove = SKAction.moveTo(y: sprite.position.y - menuBoxY, duration: 1)
        spriteMove.timingMode = .easeOut
        sprite.run(spriteMove)
        /*
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false){timer in
            playSound(soundPlayer: SPKey.menuSlideUpSoundPlayer)
        }
         */
    }
   
}

func menuExit(self:SKScene, boxArr:[SKNode], moveOutDur: Double){
    
    menuAnimationActive = true
    //scootdown
    for sprite in boxArr{
        let spriteMove = SKAction.moveTo(y: sprite.position.y - screenHeight/40, duration: 0.3)
        spriteMove.timingMode = .easeOut
        sprite.run(spriteMove)
        
    }
    
    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false){timer in
        let moveMenu = SKAction.run {
            for sprite in boxArr{
                let spriteMove = SKAction.moveTo(y: screenHeight, duration: moveOutDur)
                spriteMove.timingMode = .easeIn
            
                let eraseSprite = SKAction.run {
                    sprite.removeFromParent()
                }
                //sprite.run(spriteMove)
                sprite.run(SKAction.sequence([spriteMove, eraseSprite]))
            }
            playSound(soundPlayer: SPKey.menuSlideDownSoundPlayer)
        }
        
        self.run(moveMenu)
        
    }
    
    
}

func replayButtonClicked(self:SKScene){
    playAgain.texture = SKTexture(imageNamed: "replayButton")
    
    playAgainButtonActive = false
    replayButtonHasBeenClicked = true
    
    
    menuExit(self: self, boxArr: [menuBox, playAgain, scoreWordLabel, scoreNumberLabel, backToHomeButton], moveOutDur: 0.8)
    Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false){timer in
        menuAnimationActive = false
        
        self.removeAllChildren()
        let temp = GameScene(fileNamed: "GameScene")
        self.scene?.view?.presentScene(temp!, transition: SKTransition.fade(withDuration: 0.8))
    }
}


func menuHomeButtonClicked(self:SKScene){
    backToHomeButton.texture = SKTexture(imageNamed: "menuHomeButton")
    playAgainButtonActive = false
    menuExit(self: self, boxArr: [menuBox, playAgain, scoreWordLabel, scoreNumberLabel, backToHomeButton], moveOutDur: 1)
    Timer.scheduledTimer(withTimeInterval: 1, repeats: false){timer in
        menuAnimationActive = false
        
        self.removeAllChildren()
        let temp = GameScene(fileNamed: "GameScene")
        self.scene?.view?.presentScene(temp!, transition: SKTransition.fade(withDuration: 0.8))
    }
    
}
