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
func addInventoryButton(self:SKScene, pos:CGPoint){
    
    let diameter = screenHeight / 30
    inventoryButton = SKSpriteNode(color: .blue, size: CGSize(width: diameter, height: diameter))
    inventoryButton.position  = pos
    inventoryButton.texture = SKTexture(imageNamed: "inventoryButton")
    
    self.addChild(inventoryButton)
}

//PRESENT INVENTORY SCENE
func goToInventory(self:SKScene){
    inventoryButton.texture = SKTexture(imageNamed: "inventoryButton")
    let temp = InventoryScene(fileNamed: "InventoryScene")
    self.scene?.view?.presentScene(temp!, transition: SKTransition.fade(withDuration: 1))
    
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
    equipButton = SKSpriteNode(color: .orange, size: CGSize(width: screenHeight/10, height: screenHeight/25))
    equipButton.texture = SKTexture(imageNamed: "equipButton")
    equipButton.position = CGPoint(x:0, y: -screenHeight/6 + yCoord)
    setEquipButtonAsEquipped()
    
    makeModelNode(pos: CGPoint(x:inventoryNodeX, y:yCoord), node: &skinModelNode)
    skinModelNode.texture = skinDictionary[userDefaults.value(forKey: UDKey.equippedSkin) as! String]!.faceDown
    
    makeModelNode(pos: CGPoint(x: inventoryNodeX + screenHeight/3, y:yCoord), node: &skinModelNode2)
    
    self.addChild(equipButton)
    self.addChild(skinModelNode)
    self.addChild(skinModelNode2)

}


//EQUIPPED BUTTON CLICKED
func equipButtonClicked(){
    //equipButton.texture = SKTexture(imageNamed: "equippedButton")
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

//RIGHT ARROW
func rightArrowClicked(self: SKScene){
    rightInventoryArrow.texture = SKTexture(imageNamed: "rightArrow")
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
        rotatePresentedSkin(self: self, nodeA: &skinModelNode, nodeB: &skinModelNode2, rightClicked: true)
    }else{
        skinModelNode.texture = skinDictionary[invList[currentSkinInd]]!.faceDown
        rotatePresentedSkin(self: self, nodeA: &skinModelNode2, nodeB: &skinModelNode, rightClicked: true)
    }
}

//LEFT ARROW
func leftArrowClicked(self:SKScene){
    leftInventoryArrow.texture = SKTexture(imageNamed: "leftArrow")
    //check if loop
    let invList = userDefaults.value(forKey: UDKey.inventory) as! [String]
    if currentSkinInd == 0{
        currentSkinInd = invList.count - 1
    }else{
        currentSkinInd -= 1
    }
    
    
    if skinModelNode.position.x == inventoryNodeX{
        skinModelNode2.texture = skinDictionary[invList[currentSkinInd]]!.faceDown
        rotatePresentedSkin(self: self, nodeA: &skinModelNode, nodeB: &skinModelNode2, rightClicked: false)
    }else{
        skinModelNode.texture = skinDictionary[invList[currentSkinInd]]!.faceDown
        rotatePresentedSkin(self: self, nodeA: &skinModelNode2, nodeB: &skinModelNode, rightClicked: false)
    }
}

//ANIMATION
func rotatePresentedSkin(self: SKScene, nodeA: inout SKSpriteNode, nodeB: inout SKSpriteNode, rightClicked: Bool){
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
    
    move1.timingMode = .easeOut
    move2.timingMode = .easeOut
    
    nodeA.run(SKAction.sequence([move2, turnOff]))
    nodeB.run(move1)
}



func addResetButton(self:SKScene){
    
    resetButton = SKSpriteNode(color: .red, size: CGSize(width: screenHeight/20, height: screenHeight/20))
    resetButton.position = CGPoint(x: -screenHeight/10, y: -screenHeight/7)
    
    self.addChild(resetButton)
}

func resetStats(self:SKScene){
    userDefaults.setValue(["0"], forKey: UDKey.inventory)
    userDefaults.setValue("0", forKey: UDKey.equippedSkin)
    userDefaults.setValue(Skins.common, forKey: UDKey.commonRemainingSkins)
    userDefaults.setValue(Skins.epic, forKey: UDKey.epicRemainingSkins)
}




