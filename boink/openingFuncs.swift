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
    if userDefaults.value(forKey: UDKey.commonRemainingSkins) == nil{ //|| userDefaults.value(forKey: UDKey.commonRemainingSkins) as! [String] == []{
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
    
    
    //CHOSE SKIN AND MAKE SKIN NODE
    let chosen = chosenRandomSkin(self: self)
    
    let skinNodeImage = SKSpriteNode(color: .white, size: CGSize(width: screenHeight/16, height: screenHeight/16))
    skinNodeImage.texture = chosen.faceDown
    skinNodeImage.position = crateImage.position
    skinNodeImage.zPosition = crateImageZPosition + 1
    skinNodeImage.removeFromParent()
    
    let skinMoveOut = SKAction.moveTo(y: -screenHeight/10, duration: 0.5)
    skinMoveOut.timingMode = .easeOut
    
    //shake
    let shakeCrate = [initPause, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveRight, moveLeft, moveCenter]
    
    //reveal skin
    let addSkin = SKAction.run {
        self.addChild(skinNodeImage)
    }
    
    //zoom skin
    let zoomInSkin = SKAction.run {
        
        //zoom in and fade out crate
        let dur = 0.6
        crateImage.run(SKAction.fadeOut(withDuration: dur))
        crateImage2.run(SKAction.fadeOut(withDuration: dur))
        skinNodeImage.run(SKAction.resize(toWidth: screenHeight/8 , height: screenHeight/8 , duration: dur))
        skinNodeImage.run(SKAction.moveTo(y: screenHeight/12, duration: dur))
        
        //add back and inv button
        Timer.scheduledTimer(withTimeInterval: dur * 2, repeats: false){timer in
            print("HIHIHIHIHI")
            //back
            addBackToGameButton(self: self, pos: CGPoint(x: -screenHeight/20, y: -screenHeight/12))
            backToGameButton.alpha = 0
            backToGameButton.run(SKAction.fadeIn(withDuration: dur/2))
            
            //inv
            addInventoryButton(self: self, pos: CGPoint(x: screenHeight/20, y: -screenHeight/12))
            inventoryButton.alpha = 0
            inventoryButton.run(SKAction.fadeIn(withDuration: dur/2))
        }
        
    }
    
    let moveSkin = SKAction.run{
        skinNodeImage.run(SKAction.sequence([initPause, skinMoveOut]))
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false){timer in

            skinNodeImage.run(zoomInSkin)
            }
    }
    
    //TODO
    
    crateImage.run(SKAction.sequence(shakeCrate))
    crateImage2.run(SKAction.sequence(shakeCrate + [addSkin, moveSkin]))
    
    
    
    
    
    
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
