//
//  openingFuncs.swift
//  boink
//
//  Created by Dylan Dang on 2/20/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit
import SwiftUI


func chooseRandomSkin(self: SKScene){
    let randomNum = Int.random(in: 0..<101)
    let skins:[String]
    
    if randomNum <= 95{
        skins = availableSkins(rarity: rarityKey.common)
    }else{
        skins = availableSkins(rarity: rarityKey.epic)
    }
    
    print(skins)
    
     
     
    let chosenSkin = skins.randomElement()!
    
    
    addToInventory(skinID: chosenSkin)
    currentUnboxedSkinInd = chosenSkin
    currentUnboxedSkin = skinDictionary[chosenSkin]!
    
    
    
}

func availableSkins(rarity: Int) -> [String]{
    var avaSkins:[String] = []
    let ownedSkins = userDefaults.value(forKey: UDKey.inventory) as! [String]
    
    if rarity == rarityKey.common{
        for skin in Skins.common{
            if !ownedSkins.contains(skin){
                avaSkins.append(skin)
            }
        }
        
        //no more in common
        if avaSkins.count == 0{
            for skin in Skins.epic{
                if !ownedSkins.contains(skin){
                    avaSkins.append(skin)
                }
            }
        }
    }else if rarity == rarityKey.epic{
        for skin in Skins.epic{
            if !ownedSkins.contains(skin){
                avaSkins.append(skin)
            }
        }
        
        //no more in epic
        if avaSkins.count == 0{
            for skin in Skins.common{
                if !ownedSkins.contains(skin){
                    avaSkins.append(skin)
                }
            }
        }
        
    }
    
    
    return avaSkins
    
}





//CRATE
func crateOpeningAnimation(self:SKScene){
    
    //SHAKE CRATE VARS
    let diff = screenHeight/60
    let moveRight = SKAction.moveTo(x: diff, duration: 0.15)
    let moveLeft = SKAction.moveTo(x: -diff, duration: 0.15)
    let moveCenter = SKAction.moveTo(x: 0, duration: 0.075)
    let initPause = SKAction.wait(forDuration: 0.7)
    let smPause = SKAction.wait(forDuration: 0.2)
    let bigPause = SKAction.wait(forDuration: 2.4)
    
    
    
    
    let mysteryPackage = SKSpriteNode(color: .black, size: CGSize(width: screenHeight/25, height: screenHeight/25))
    
    if currentUnboxedSkin.rarity == rarityKey.common || currentUnboxedSkin.rarity == rarityKey.def{
        mysteryPackage.texture = SKTexture(imageNamed: "mysteryPackage")
    }else{
        mysteryPackage.texture = SKTexture(imageNamed: "goldenMysteryPackage")
    }
    mysteryPackage.position = CGPoint(x: crateImage.position.x, y: crateImage.position.y - screenHeight/18)
    mysteryPackage.zPosition = crateImageZPosition + 1
    mysteryPackage.removeFromParent()
    
    let packMoveOut = SKAction.run{
        let move = SKAction.moveTo(y: -screenHeight/10, duration: 0.5)
        move.timingMode = .easeOut
        
        mysteryPackage.run(move)
    
    }
    
    var x = 0
    let shakeSound  = SKAction.run {
        if x == 0{
            playSound(soundPlayer: SPKey.mysteryBoxShakeSoundPlayer)
        }
        x += 1
    }
    
    //shake
    let shakeCrate = [initPause, shakeSound, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveCenter]
    
    //reveal skin
    let addMysterySkin = SKAction.run {
        self.addChild(mysteryPackage)
    }
    
    let chaching = SKAction.run {
        playSound(soundPlayer: SPKey.chaching)
    }
    
    //zoom in on mysterypackage
    let zoomIn = SKAction.run{
        let t = 0.7
        crateImage.run(SKAction.fadeOut(withDuration: t))
        crateImage2.run(SKAction.fadeOut(withDuration: t))
        mysteryPackage.run(SKAction.resize(toWidth: screenHeight/8 , height: screenHeight/8 , duration: t))
        mysteryPackage.run(SKAction.moveTo(y: 0, duration: t))
        playSound(soundPlayer: SPKey.mysteryBoxDispenseSoundPlayer)
    }
    
    //transition scene
    let nextScene = SKAction.run {
        let temp = SkinRevealScene(fileNamed: "SkinRevealScene")
        self.scene?.view?.presentScene(temp!, transition: SKTransition())
    }
    
    crateImage.run(SKAction.sequence(shakeCrate + [addMysterySkin, chaching, smPause, initPause, packMoveOut, initPause,initPause, zoomIn, bigPause, nextScene]))
    crateImage2.run(SKAction.sequence(shakeCrate))
    
    
    
    
    
    
}

//add new skin to inventory (in chooseRandomSkin func)
func addToInventory(skinID: String){
    
    let skin = skinDictionary[skinID]
    //move into inventory
    if userDefaults.value(forKey: UDKey.inventory) != nil{
        var array = userDefaults.object(forKey: UDKey.inventory) as! [String]
        array.append(skinID)
        
        userDefaults.setValue(array, forKey: UDKey.inventory)
    }else{
        userDefaults.setValue(["0", skinID], forKey: UDKey.inventory)
    }
}












//SKIN REVEAL FUNCS



func addChosenSkin(self: SKScene){
    
    let whiteFlash = SKSpriteNode(color: .white, size: self.frame.size)
    whiteFlash.position = CGPoint(x:0, y:0)
    whiteFlash.zPosition = CGFloat(Int8.max - 1)
    
    //boxbreak
    let brokenPackage1 = SKSpriteNode(color: .blue, size: CGSize(width: screenHeight/8, height: screenHeight/8))
    brokenPackage1.position = CGPoint(x:-screenHeight/300, y:0)
    brokenPackage1.alpha = 0.75
    brokenPackage1.zPosition = whiteFlash.zPosition + 1
    
    let brokenPackage2 = SKSpriteNode(color: .blue, size: CGSize(width: screenHeight/8, height: screenHeight/8))
    brokenPackage2.position = CGPoint(x:screenHeight/300, y:0)
    brokenPackage2.alpha = 0.75
    brokenPackage2.zPosition = whiteFlash.zPosition + 1
    
    if currentUnboxedSkin.rarity == rarityKey.common{
        brokenPackage1.texture = SKTexture(imageNamed: "mysteryPackageBreak1")
        brokenPackage2.texture = SKTexture(imageNamed: "mysteryPackageBreak2")
    }else{
        brokenPackage1.texture = SKTexture(imageNamed: "goldenMysteryPackageBreak1")
        brokenPackage2.texture = SKTexture(imageNamed: "goldenMysteryPackageBreak2")
        
        whiteFlash.color = color(hex: "FBF4B5")
    }
    
    //skin
    let chosenNode = SKSpriteNode(color: .white, size: CGSize(width: screenHeight/5.8 , height: screenHeight/5.8))
    if currentUnboxedSkin.rarity == rarityKey.epic{
        chosenNode.size = CGSize(width: screenHeight/4.7, height: screenHeight/4.7)
    }
    chosenNode.texture = currentUnboxedSkin.faceDown
    chosenNode.position = CGPoint(x:0, y:0)
    
    
    //name
    let chosenName = SKLabelNode(text: currentUnboxedSkin.skinName)
    chosenName.fontSize = screenHeight/18 * 5 / CGFloat(currentUnboxedSkin.skinName.count)
    chosenName.fontName = currentFont
    chosenName.position = CGPoint(x: 0, y: screenHeight/10)
    chosenName.fontColor = .black
    chosenName.alpha = 0
    
    let youUnlocked = SKLabelNode(text: "YOU HAVE UNLOCKED:")
    youUnlocked.fontSize = screenHeight/60
    youUnlocked.fontName = currentFont
    youUnlocked.position = CGPoint(x:0, y: screenHeight/5.6)
    youUnlocked.fontColor = .black
    youUnlocked.alpha = 0
    
    
    self.addChild(whiteFlash)
    self.addChild(chosenNode)
    self.addChild(chosenName)
    self.addChild(youUnlocked)
    self.addChild(brokenPackage1)
    self.addChild(brokenPackage2)
    
    //actions
    let halfPause = SKAction.wait(forDuration: 0.2)
    let pause = SKAction.wait(forDuration: 0.4)
    let fade = SKAction.fadeOut(withDuration: 0.5)
    
    //breaks
    let breakPackage = SKAction.run{
        let d = 0.1
        let rm = SKAction.run{
            brokenPackage1.removeFromParent()
            brokenPackage2.removeFromParent()
        }
        brokenPackage1.run(SKAction.sequence([SKAction.move(to: CGPoint(x: -self.frame.width, y: 0), duration: d), rm]))
        brokenPackage2.run(SKAction.move(to: CGPoint(x: self.frame.width, y: 0), duration: d))
        
    }
    
    //THUMP SKIN
    let nodeBob = SKAction.run{
        let nodeBobBack = SKAction.resize(toWidth: screenHeight/11, height: screenHeight/11, duration: 0.65)
        nodeBobBack.timingMode = .easeIn
        
        chosenNode.run(nodeBobBack)
        playSound(soundPlayer: SPKey.titleStompSoundPlayer)
        
        
    }
    
    //add text
    let addUnlocked = SKAction.run{
        youUnlocked.run(SKAction.fadeIn(withDuration: 0.3))
    }
    
    //play reveal music
    let playMusic = SKAction.run {
        if currentUnboxedSkin.rarity == rarityKey.common{
            playSound(soundPlayer: SPKey.revealSkinMusic)
        }else if currentUnboxedSkin.rarity == rarityKey.epic{
            playSound(soundPlayer: SPKey.epicRevealSkinMusic)
        }
    }
    
    
    let addName = SKAction.run{
        chosenName.run(SKAction.fadeIn(withDuration: 0.7))
    }
    
    //add buttons
    let addButtons = SKAction.run{
        addSkinRevealButtons(self: self)
    }
    
    //call
    playSound(soundPlayer: SPKey.mysteryPackageBreak)
    whiteFlash.run(SKAction.sequence([pause, SKAction.group([breakPackage, fade, nodeBob]), pause, pause, addUnlocked, halfPause, playMusic, halfPause, addName, pause, pause, addButtons]))
    
    
    
}


func addSkinRevealButtons(self:SKScene){
    let dur = 0.8
    //back
    addBackToGameButton(self: self, pos: CGPoint(x: -screenHeight/20, y: -screenHeight/6), diameter: screenHeight/22)
    backToGameButton.alpha = 0
    backToGameButton.run(SKAction.fadeIn(withDuration: dur))
    
    //inv
    addInventoryButton(self: self, pos: CGPoint(x: screenHeight/20, y: -screenHeight/6), diameter: screenHeight/22)
    inventoryButton.alpha = 0
    inventoryButton.run(SKAction.fadeIn(withDuration: dur))
    
    //equip
    addEquipButton(self: self, pos: CGPoint(x: 0 , y: -screenHeight/9), size: CGSize(width: screenHeight/10, height: screenHeight/25))
    equipButton.alpha = 0
    equipButton.run(SKAction.fadeIn(withDuration: dur))
    
    
    
}
