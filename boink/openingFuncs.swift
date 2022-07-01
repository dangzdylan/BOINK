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


func chosenRandomSkin(self: SKScene) -> ObjectSkin{
    //let randomNum = Int.random(in: 1..<101)
    let skin:[String]
    
    //TAKE OUT SECOND CONDITION!!!!!!!!!!!!!!!!!!!
    if userDefaults.value(forKey: UDKey.commonRemainingSkins) == nil{
        userDefaults.setValue(Skins.common, forKey: UDKey.commonRemainingSkins)
        userDefaults.setValue(Skins.epic, forKey: UDKey.epicRemainingSkins)
    }
    
    /*
     
    //FOR EPIC SKINS FUTURE UPDATE
    //COMMON
    if (randomNum <= 95 && userDefaults.object(forKey: UDKey.commonRemainingSkins) as! [String] != []) || (userDefaults.object(forKey: UDKey.epicRemainingSkins) as! [String] != []){
        skin = userDefaults.object(forKey: UDKey.commonRemainingSkins) as! [String]
    //EPIC
    }else{
        
        skin = userDefaults.object(forKey: UDKey.epicRemainingSkins) as! [String]
    }
     
     */
    
    skin = userDefaults.object(forKey: UDKey.commonRemainingSkins) as! [String]
    let chosenSkin = skin.randomElement()!
    
    
    addToInventory(skinID: chosenSkin)
    return skinDictionary[chosenSkin]!
}

func crateOpeningAnimation(self:SKScene){
    
    //SHAKE CRATE VARS
    let diff = screenHeight/60
    let moveRight = SKAction.moveTo(x: diff, duration: 0.15)
    let moveLeft = SKAction.moveTo(x: -diff, duration: 0.15)
    let moveCenter = SKAction.moveTo(x: 0, duration: 0.075)
    let initPause = SKAction.wait(forDuration: 0.7)
    let bigPause = SKAction.wait(forDuration: 1.8)
    
    
    
    
    let mysteryPackage = SKSpriteNode(color: .black, size: CGSize(width: screenHeight/18, height: screenHeight/18))
    mysteryPackage.texture = SKTexture(imageNamed: "mysteryPackage")
    mysteryPackage.position = crateImage.position
    mysteryPackage.zPosition = crateImageZPosition + 1
    mysteryPackage.removeFromParent()
    
    let packMoveOut = SKAction.run{
        let move = SKAction.moveTo(y: -screenHeight/10, duration: 0.5)
        move.timingMode = .easeOut
        
        mysteryPackage.run(move)
    
    }
    
    //shake
    let shakeCrate = [initPause, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveCenter]
    
    //reveal skin
    let addMysterySkin = SKAction.run {
        self.addChild(mysteryPackage)
    }
    
    //zoom in on mysterypackage
    let zoomIn = SKAction.run{
        let t = 0.7
        crateImage.run(SKAction.fadeOut(withDuration: t))
        crateImage2.run(SKAction.fadeOut(withDuration: t))
        mysteryPackage.run(SKAction.resize(toWidth: screenHeight/10 , height: screenHeight/10 , duration: t))
        mysteryPackage.run(SKAction.moveTo(y: 0, duration: t))
    }
    
    //transition scene
    let nextScene = SKAction.run {
        let temp = SkinRevealScene(fileNamed: "SkinRevealScene")
        self.scene?.view?.presentScene(temp!, transition: SKTransition())
    }
    
    crateImage.run(SKAction.sequence(shakeCrate + [addMysterySkin, initPause, packMoveOut,initPause, zoomIn, bigPause, nextScene]))
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
    
    //take out skin from remaining set of skins
    var tempArr = userDefaults.object(forKey: determinedSkinRarity(skin: skin!)) as! [String]
    tempArr = tempArr.filter{ $0 != skinID}
    userDefaults.setValue(tempArr, forKey: determinedSkinRarity(skin: skin!))
}

//skin rarity (in addToInventory func)
func determinedSkinRarity(skin: ObjectSkin) -> String{
    if skin.rarity == rarityKey.common{
        return UDKey.commonRemainingSkins
    }else if skin.rarity == rarityKey.rare{
        return UDKey.rareRemainingSkins
    }else if skin.rarity == rarityKey.epic{
        return UDKey.epicRemainingSkins
    }else{
        return UDKey.legendaryRemainingSkins
    }
}







//SKIN REVEAL FUNCS



func addChosenSkin(self: SKScene){
    let whiteFlash = SKSpriteNode(color: .white, size: self.frame.size)
    whiteFlash.position = CGPoint(x:0, y:0)
    whiteFlash.zPosition = CGFloat(Int8.max)
    
    let chosen = chosenRandomSkin(self: self)
    
    let chosenNode = SKSpriteNode(color: .white, size: CGSize(width: screenHeight/11 , height: screenHeight/11))
    chosenNode.texture = chosen.faceDown
    chosenNode.position = CGPoint(x:0, y:0)
    
    let chosenName = SKLabelNode(text: chosen.skinName)
    chosenName.fontSize = screenHeight/18 * 5 / CGFloat(chosen.skinName.count)
    chosenName.fontName = currentFont
    chosenName.position = CGPoint(x: 0, y: screenHeight/10)
    chosenName.fontColor = .white
    chosenName.alpha = 0
    
    self.addChild(whiteFlash)
    self.addChild(chosenNode)
    self.addChild(chosenName)
    
    
    let pause = SKAction.wait(forDuration: 0.4)
    let fade = SKAction.fadeOut(withDuration: 1)
    let addName = SKAction.run{
        chosenName.run(SKAction.fadeIn(withDuration: 0.7))
    }
    let addButtons = SKAction.run{
        addSkinRevealButtons(self: self)
    }
    
    whiteFlash.run(SKAction.sequence([pause, fade, pause, addName, pause, pause, addButtons]))
    
    
    
}


func addSkinRevealButtons(self:SKScene){
    let dur = 0.8
    //back
    addBackToGameButton(self: self, pos: CGPoint(x: -screenHeight/20, y: -screenHeight/9), diameter: screenHeight/22)
    backToGameButton.alpha = 0
    backToGameButton.run(SKAction.fadeIn(withDuration: dur))
    
    //inv
    addInventoryButton(self: self, pos: CGPoint(x: screenHeight/20, y: -screenHeight/9), diameter: screenHeight/22)
    inventoryButton.alpha = 0
    inventoryButton.run(SKAction.fadeIn(withDuration: dur))
    
}
