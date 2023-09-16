//
//  inventoryFuncs.swift
//  boink
//
//  Created by Dylan Dang on 2/19/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit

//INV BUTTON ON OTHER SCENES
func addInventoryButton(self:SKScene, pos:CGPoint, diameter: CGFloat){
    
    let d = diameter
    inventoryButton = SKSpriteNode(color: .blue, size: CGSize(width: d, height: d))
    inventoryButton.position  = pos
    inventoryButton.texture = SKTexture(imageNamed: "inventoryButton")
    
    self.addChild(inventoryButton)
}

//PRESENT INVENTORY SCENE
func goToInventory(self:SKScene){
    
    playSound(soundPlayer: SPKey.buttonClick)
    
    inventoryButton.texture = SKTexture(imageNamed: "inventoryButton")
    let temp = InventoryScene(fileNamed: "InventoryScene")
    self.scene?.view?.presentScene(temp!, transition: SKTransition.fade(withDuration: 0.8))
    
}

func addInventoryBackground(self:SKScene){
    let background = SKSpriteNode(imageNamed: "inventoryBackground")
    background.size = self.frame.size
    background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    background.zPosition = -CGFloat(UInt8.max)
    self.addChild(background)
}

//ADD NODES
func addInvNodes(self:SKScene){
    //ARROWS
    let size = CGSize(width: screenHeight/18, height: screenHeight/4)
    let yCoord = screenHeight/30
    rightInventoryArrow = SKSpriteNode(color: .red, size: size)
    rightInventoryArrow.position = CGPoint(x: screenWidth/4 - screenHeight/36, y: yCoord)
    rightInventoryArrow.texture = SKTexture(imageNamed: "rightArrow")
    rightInventoryArrow.zPosition = CGFloat(UInt8.max)
    
    leftInventoryArrow = SKSpriteNode(color: .green, size: size)
    leftInventoryArrow.position = CGPoint(x: -screenWidth/4 + screenHeight/36, y:yCoord)
    leftInventoryArrow.texture = SKTexture(imageNamed: "leftArrow")
    leftInventoryArrow.zPosition = CGFloat(UInt8.max)
    
    self.addChild(rightInventoryArrow)
    self.addChild(leftInventoryArrow)
    
    //EQUIP AND MODEL NODE
    addEquipButton(self: self, pos: CGPoint(x: 0, y: -screenHeight/8 + yCoord), size: CGSize(width: screenHeight/10, height: screenHeight/25))
    setEquipButtonAsEquipped()
    
    makeModelNode(pos: CGPoint(x:inventoryNodeX, y:yCoord), node: &skinModelNode)
    skinModelNode.texture = skinDictionary[userDefaults.value(forKey: UDKey.equippedSkin) as! String]!.faceDown
    
    makeModelNode(pos: CGPoint(x: inventoryNodeX + screenHeight/3, y:yCoord), node: &skinModelNode2)
    
    
    self.addChild(skinModelNode)
    self.addChild(skinModelNode2)

}

func addEquipButton(self:SKScene, pos:CGPoint, size:CGSize){
    equipButton = SKSpriteNode(color: .orange, size: size)
    equipButton.texture = SKTexture(imageNamed: "equipButton")
    equipButton.position = pos
    
    self.addChild(equipButton)
    
}


//EQUIPPED BUTTON CLICKED
func equipButtonClicked(){
    playSound(soundPlayer: SPKey.equippedButtonClick)
    
    setEquipButtonAsEquipped()
    
    let invList = userDefaults.value(forKey: UDKey.inventory) as! [String]
    
    userDefaults.setValue(invList[currentSkinInd], forKey: UDKey.equippedSkin)
    skinDictionary[invList[currentSkinInd]]!.equip()
}

func setEquipButtonAsEquipped(){
    equipButton.texture = SKTexture(imageNamed: "equippedButton")
}

func makeModelNode(pos: CGPoint, node: inout SKSpriteNode){
    node = SKSpriteNode(color: .brown, size:CGSize(width: screenHeight/10, height: screenHeight/10))
    node.position = pos
}

func getIndexOfEquippedSkin(){
    if userDefaults.value(forKey: UDKey.inventory) == nil{
        userDefaults.setValue(["0"], forKey: UDKey.inventory)
    }
    let invList = userDefaults.value(forKey: UDKey.inventory) as! [String]
    
    for i in 0..<invList.count{
        if invList[i] == userDefaults.value(forKey: UDKey.equippedSkin) as! String{
            currentSkinInd = i
            break
        }
    }
}

//LEFT ARROW
func leftArrowClicked(self: SKScene){
    leftInventoryArrow.texture = SKTexture(imageNamed: "leftArrow")
    //check if loop
    let invList = userDefaults.value(forKey: UDKey.inventory) as! [String]
    if currentSkinInd + 1 == invList.count{
        currentSkinInd = 0
    }else{
        currentSkinInd += 1
    }
    
    //MOVE ANIMATION
    if skinModelNode.position.x == inventoryNodeX {
        print(invList)
        skinModelNode2.texture = skinDictionary[invList[currentSkinInd]]!.faceDown
        rotatePresentedSkin(self: self, nodeA: &skinModelNode, nodeB: &skinModelNode2, rightClicked: true, curObj: skinDictionary[invList[currentSkinInd]]!)
    }else{
        skinModelNode.texture = skinDictionary[invList[currentSkinInd]]!.faceDown
        rotatePresentedSkin(self: self, nodeA: &skinModelNode2, nodeB: &skinModelNode, rightClicked: true, curObj: skinDictionary[invList[currentSkinInd]]!)
    }
}

//RIGHT ARROW
func rightArrowClicked(self:SKScene){
    rightInventoryArrow.texture = SKTexture(imageNamed: "rightArrow")
    //check if loop
    let invList = userDefaults.value(forKey: UDKey.inventory) as! [String]
    if currentSkinInd == 0{
        currentSkinInd = invList.count - 1
    }else{
        currentSkinInd -= 1
    }
    
    
    if skinModelNode.position.x == inventoryNodeX{
        skinModelNode2.texture = skinDictionary[invList[currentSkinInd]]!.faceDown
        rotatePresentedSkin(self: self, nodeA: &skinModelNode, nodeB: &skinModelNode2, rightClicked: false, curObj: skinDictionary[invList[currentSkinInd]]!)
    }else{
        skinModelNode.texture = skinDictionary[invList[currentSkinInd]]!.faceDown
        rotatePresentedSkin(self: self, nodeA: &skinModelNode2, nodeB: &skinModelNode, rightClicked: false, curObj: skinDictionary[invList[currentSkinInd]]!)
    }
}

//ANIMATION
func rotatePresentedSkin(self: SKScene, nodeA: inout SKSpriteNode, nodeB: inout SKSpriteNode, rightClicked: Bool, curObj: ObjectSkin){
    //sound
    playSound(soundPlayer: SPKey.inventoryArrowClick)
    
    
    //check if next is equipped
    let invList = userDefaults.value(forKey: UDKey.inventory) as! [String]
    arrowAnimationOn = true
    var mult:CGFloat = 1
    if rightClicked{
        mult *= -1
    }
    nodeB.position = CGPoint(x: mult * screenHeight/3, y: screenHeight/30)
    
    let move1 = SKAction.moveTo(x: inventoryNodeX, duration: 0.3)
    let move2 = SKAction.moveTo(x: -mult * screenHeight/3, duration: 0.3)
    let turnOff = SKAction.run {
        arrowAnimationOn = false
        //equip button
        if invList[currentSkinInd] == userDefaults.value(forKey: UDKey.equippedSkin) as! String{
            setEquipButtonAsEquipped()
        }else{
            equipButton.texture = SKTexture(imageNamed: "equipButton")
        }
    }
    
    //change backg color
    let changeBackground = SKAction.run{
        if curObj.rarity == rarityKey.epic{
            self.backgroundColor = curObj.background
            changePlayAreaBackgroundColor(c: curObj.background)
        }else{
            self.backgroundColor = inventoryBackgroundColor
            changePlayAreaBackgroundColor(c: inventoryBackgroundColor)
        }
    }
    
    
    //run
    move1.timingMode = .easeOut
    move2.timingMode = .easeOut
    
    nodeA.run(SKAction.sequence([move2, changeBackground, turnOff]))
    nodeB.run(move1)
}



func addResetButton(self:SKScene){
    
    resetButton = SKSpriteNode(color: .red, size: CGSize(width: screenHeight/20, height: screenHeight/20))
    resetButton.texture = SKTexture(imageNamed: "resetButton")
    resetButton.position = CGPoint(x: -screenHeight/14, y: -screenHeight/7)
    
    self.addChild(resetButton)
}

func resetStats(self:SKScene){
    userDefaults.setValue(["0"], forKey: UDKey.inventory)
    userDefaults.setValue("0", forKey: UDKey.equippedSkin)
}




