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
    }else if scoreNum == 3 * tempMultiplier1{
        fourthLevel(self:self)
    }else if scoreNum == 4 * tempMultiplier1{
        fifthLevel(self:self)
    }else if scoreNum == 5 * tempMultiplier1{
        sixthLevel(self: self)
    }else if scoreNum == 6 * tempMultiplier1{
        seventhLevel(self: self)
    }else if scoreNum == 7 * tempMultiplier1{
        eigthLevel(self: self)
    }else if scoreNum == 8 * tempMultiplier1{
        ninthLevel(self: self)
    }else if scoreNum == 9 * tempMultiplier1{
        tenthLevel(self: self)
    }else if scoreNum == 10 * tempMultiplier1{
        eleventhLevel(self: self)
    }else if scoreNum == 6 * tempMultiplier2{
        twelfthLevel(self: self)
    }else if scoreNum == 7 * tempMultiplier2{
        thirteenthLevel(self: self)
    }else if scoreNum == 8 * tempMultiplier2{
        fourteenthLevel(self: self)
    }
}


func secondLevel(self:SKScene){
    setNodeSpeeds(p: 1.05, m: 1.05)
}

//10
func thirdLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 2)
    spawnMonster(self: self)
    setNodeSpeeds(p: 1, m: 1)
}

func fourthLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 3)
    setNodeSpeeds(p: 1.055, m: 1.05)
}

//20
func fifthLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 4)
    spawnMonster(self: self)
    setNodeSpeeds(p: 0.897, m: 0.895)
}
func sixthLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 5)
    coinMultiplier = 2
    setNodeSpeeds(p: 0.9082, m: 0.905)
}
func seventhLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 6)
    setNodeSpeeds(p: 0.92, m: 0.91)
    
}
func eigthLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 7)
    setNodeSpeeds(p: 0.928, m: 0.9165)
}
func ninthLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 8)
    setNodeSpeeds(p: 0.9365, m: 0.925)
    
}

func tenthLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 9)
    setNodeSpeeds(p: 0.945, m: 0.935)
}

//50
func eleventhLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 10)
    spawnMonster(self: self)
    coinMultiplier = 3
    setNodeSpeeds(p: 0.914, m: 0.906)
}

func twelfthLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 11)
    setNodeSpeeds(p: 0.931, m: 0.92)
}

func thirteenthLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 12)
    setNodeSpeeds(p: 0.937, m: 0.927)
    
}

//80
func fourteenthLevel(self:SKScene){
    chooseBackgroundIndex(self: self, ind: 13)
    spawnMonster(self: self)
    coinMultiplier = 4
    setNodeSpeeds(p: 0.905, m: 0.905)
}



//help funcs
func chooseBackgroundIndex(self:SKScene, ind:Int){
    setBackground(self: self, chosenColor: backgroundColorWays[ind]!, borderBackgroundtext: borderBackgroundTextures(ind: ind))
}
func setNodeSpeeds(p:CGFloat, m:CGFloat){
    monsterSpeed = monsterSpeedConstant * m
    playerSpeed = playerSpeedConstant * p
}
