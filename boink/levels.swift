//
//  levels.swift
//  boink
//
//  Created by Dylan Dang on 9/19/21.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit



func checkForChangeLevel(self:SKScene){
    
    let tempMultiplier1 = 5
    let tempMultiplier2 = tempMultiplier1 * 2
    if scoreNum == 1 * tempMultiplier1{
        secondLevel(self:self)
    }else if scoreNum == 2 * tempMultiplier1{
        thirdLevel(self:self)
        coinMultiplier += 1
    }else if scoreNum == 3 * tempMultiplier1{
        fourthLevel(self:self)
    }else if scoreNum == 4 * tempMultiplier1{
        fifthLevel(self:self)
        coinMultiplier += 1
    }else if scoreNum == 5 * tempMultiplier1{
        sixthLevel(self: self)
    }else if scoreNum == 6 * tempMultiplier1{
        seventhLevel(self: self)
        coinMultiplier += 1
    }else if scoreNum == 7 * tempMultiplier1{
        eigthLevel(self: self)
    }else if scoreNum == 8 * tempMultiplier1{
        ninthLevel(self: self)
        coinMultiplier += 1
    }else if scoreNum == 9 * tempMultiplier1{
        tenthLevel(self: self)
    }else if scoreNum == 10 * tempMultiplier1{
        eleventhLevel(self: self)
        coinMultiplier += 2
    }else if scoreNum == 6 * tempMultiplier2{
        twelfthLevel(self: self)
        coinMultiplier += 1
    }else if scoreNum == 7 * tempMultiplier2{
        thirteenthLevel(self: self)
        coinMultiplier += 1
    }
}


func secondLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[2]!, borderBackgroundtext: borderBackgroundTextures[2])
    spawnMonster(self: self)
}

func thirdLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[3]!, borderBackgroundtext: borderBackgroundTextures[3])
    monsterSpeed = monsterSpeedConstant * 1.05
    playerSpeed = playerSpeedConstant * 1.055
    //monsterSpeedUpAnimation()
}

func fourthLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[4]!, borderBackgroundtext: borderBackgroundTextures[4])
    spawnMonster(self: self)
    monsterSpeed = monsterSpeedConstant * 0.895
    playerSpeed = playerSpeedConstant * 0.897
}

func fifthLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[5]!, borderBackgroundtext: borderBackgroundTextures[5])
    monsterSpeed = monsterSpeedConstant * 0.905
    playerSpeed = playerSpeedConstant * 0.9082
}
func sixthLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[6]!, borderBackgroundtext: borderBackgroundTextures[6])
    monsterSpeed = monsterSpeedConstant * 0.91
    playerSpeed = playerSpeedConstant * 0.92
}
func seventhLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[7]!, borderBackgroundtext: borderBackgroundTextures[7])
    monsterSpeed = monsterSpeedConstant * 0.9165
    playerSpeed = playerSpeedConstant * 0.928
    
}
func eigthLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[8]!, borderBackgroundtext: borderBackgroundTextures[8])
    monsterSpeed = monsterSpeedConstant * 0.925
    playerSpeed = playerSpeedConstant * 0.9365
}
func ninthLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[9]!, borderBackgroundtext: borderBackgroundTextures[9])
    monsterSpeed = monsterSpeedConstant * 0.9331
    playerSpeed = playerSpeedConstant * 0.9434
    
}

func tenthLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[10]!, borderBackgroundtext: borderBackgroundTextures[10])
    monsterSpeed = monsterSpeedConstant * 0.942
    playerSpeed = playerSpeedConstant * 0.95
}

func eleventhLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[11]!, borderBackgroundtext: borderBackgroundTextures[11])
    spawnMonster(self: self)
    monsterSpeed = monsterSpeedConstant * 0.92
    playerSpeed = playerSpeedConstant * 0.93
}

func twelfthLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[2]!, borderBackgroundtext: borderBackgroundTextures[2])
    monsterSpeed = monsterSpeedConstant * 0.927
    playerSpeed = playerSpeedConstant * 0.937
}

func thirteenthLevel(self:SKScene){
    setBackground(self: self, chosenColor: backgroundColorWays[3]!, borderBackgroundtext: borderBackgroundTextures[3])
    spawnMonster(self: self)
    monsterSpeed = monsterSpeedConstant * 0.905
    playerSpeed = playerSpeedConstant * 0.905
    
}
