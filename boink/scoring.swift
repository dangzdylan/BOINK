//
//  labels.swift
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

func addScoreLabel(self:SKScene){
    score.text = "0"
    scoreNum = 0
    score.fontSize = screenHeight/50
    score.fontName = currentFont
    score.fontColor = textBorderColor
    
    score.position = CGPoint(x: -xPointBorder + screenHeight/150, y: yPointBorder + screenHeight/90)
    score.zPosition = -10
    
    self.addChild(score)
}


func addToScore(self:SKScene){
    
    scoreNum += 1
    
    checkForChangeLevel(self: self)
    score.text = String(scoreNum)
}



func addHighScore(self:SKScene){
    if userDefaults.value(forKey: UDKey.highScore) != nil{
        //if score greater than highscore update
        if let value = userDefaults.value(forKey: UDKey.highScore) as? Int{
            if scoreNum > value{
                userDefaults.setValue(scoreNum, forKey: UDKey.highScore)
            }
        }
    
    }else{
        userDefaults.setValue(scoreNum, forKey: UDKey.highScore)
    }
    
    //highscore node dec
    let highScoreText:String = String(userDefaults.value(forKey: UDKey.highScore) as! Int)
    highScoreWordLabel = SKLabelNode(text: "HIGHSCORE: " + highScoreText)
    highScoreWordLabel.fontName = currentFont
    highScoreWordLabel.fontSize = screenHeight/50
    highScoreWordLabel.fontColor = textBorderColor
    highScoreWordLabel.position = CGPoint(x:0, y:-yPointBorder - highScoreWordLabel.fontSize)
    highScoreWordLabel.isHidden = false

    if addedHighScoreWordLabel == 1{
        self.addChild(highScoreWordLabel)
    }else{
        addedHighScoreWordLabel += 1
    }

}



func updateHighScore(self:SKScene){
    
    if let value = userDefaults.value(forKey: UDKey.highScore) as? Int{
        if scoreNum > value{
            userDefaults.setValue(scoreNum, forKey: UDKey.highScore)
        }
    }
    let highScoreText:String = String(userDefaults.value(forKey: UDKey.highScore) as! Int)
    highScoreWordLabel.text = "HIGHSCORE: " + highScoreText
    highScoreWordLabel.isHidden = false
    
    
    if GKLocalPlayer.local.isAuthenticated{
        
        //update leaderboard position
        let scoreReporter = GKScore(leaderboardIdentifier: leaderboardID)
        scoreReporter.value = Int64(userDefaults.value(forKey: UDKey.highScore) as! Int64)
        
        GKScore.report([scoreReporter], withCompletionHandler: nil)
        
        print(Int64(scoreReporter.rank))
    }
    
    
}


func makeMenuBox(self:SKScene, pos:CGPoint){
    menuBox = SKSpriteNode(color: .darkGray, size: CGSize(width:screenHeight/6, height: screenHeight/5))
    menuBox.zPosition = 100
    menuBox.texture = SKTexture(imageNamed: "menuBox")
    menuBox.position = pos
    
}











