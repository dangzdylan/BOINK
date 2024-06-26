//
//  shopFuncs.swift
//  boink
//
//  Created by Dylan Dang on 2/19/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit

//TO SHOPSCENE
func addShopButton(self:SKScene){
    
    let shopButtonSize = screenHeight / 30
    shopButton = SKSpriteNode(color: .blue, size: CGSize(width: shopButtonSize, height: shopButtonSize))
    shopButton.position  = CGPoint(x: leaderboardButton.position.x + screenHeight/18, y: leaderboardButton.position.y)
    shopButton.texture = SKTexture(imageNamed: "shopButtonIcon")
    
    self.addChild(shopButton)
    
    
    
    if userDefaults.value(forKey: UDKey.coinPurse) == nil{
        userDefaults.setValue(0, forKey: UDKey.coinPurse)
    }
    let purse:Int = userDefaults.value(forKey: UDKey.coinPurse) as! Int
    
    
    
    addCoinPurseText(self: self, pos: CGPoint(x: shopButton.position.x - (screenHeight/400 * (CGFloat)(intLength(num: purse) - 1)), y: shopButton.position.y - screenHeight/37), fSize: screenHeight/100, alph:0.6)
}


func goToShop(self:SKScene){
    playSound(soundPlayer: SPKey.buttonClick)
    
    shopButton.texture = SKTexture(imageNamed: "shopButtonIcon")
    let temp = ShopScene(fileNamed: "ShopScene")
    self.scene?.view?.presentScene(temp!, transition: SKTransition.fade(withDuration: 0.8))
}


//AWAY FROM SHOPSCENE
func addBackToGameButton(self:SKScene, pos: CGPoint, diameter: CGFloat){
    let backButtonSize = diameter
    backToGameButton = SKSpriteNode(color: .purple, size: CGSize(width: backButtonSize, height: backButtonSize))
    backToGameButton.position = pos
    backToGameButton.texture = SKTexture(imageNamed: "backButton")
    self.addChild(backToGameButton)
    
}

func goBackToGameScene(self:SKScene){
    playSound(soundPlayer: SPKey.buttonClick)
    
    backToGameButton.texture = SKTexture(imageNamed: "backButton")
    let temp = GameScene(fileNamed: "GameScene")
    self.scene?.view?.presentScene(temp!, transition: SKTransition.fade(withDuration: 0.8))
}


//PROCESS TRANSACTION
func attemptPurchase(self: SKScene){
    buyButton.texture = SKTexture(imageNamed: "buyButton")
    
    let purse = userDefaults.value(forKey: UDKey.coinPurse) as! Int
    
    //unsuccess
    if purse < mysterySkinPrice{
        unsuccessfulPurchase(self: self)
    //success
    }else{
        //play sound
        playSound(soundPlayer: SPKey.buttonClick)
        
        //take out from purse
        userDefaults.setValue(purse - mysterySkinPrice, forKey: UDKey.coinPurse)
        displayedCoinPurse.text = String(purse - mysterySkinPrice)
        chooseRandomSkin(self: self)
        //go to opening scene
        let temp = CrateOpeningScene(fileNamed: "CrateOpeningScene")
        self.scene?.view?.presentScene(temp!, transition: SKTransition.fade(withDuration: 0.01))
    }
    
}

func unsuccessfulPurchase(self: SKScene){
    //sound
    playSound(soundPlayer: SPKey.shopPurchaseFail)
    
    buyButtonAnimationActive = true
    let badTexture = SKAction.run {
        buyButton.texture = SKTexture(imageNamed: "badBuyButton")
    }
    
    let wait = SKAction.wait(forDuration: 0.7)
    
    let regTexture = SKAction.run {
        buyButton.texture = SKTexture(imageNamed: "buyButton")
        
    }
    let wait2 = SKAction.wait(forDuration: 0.5)
    
    let changeActive = SKAction.run{
        buyButtonAnimationActive = false
    }
    buyButton.run(SKAction.sequence([badTexture, wait, regTexture, wait2, changeActive]))
}

//BUY BUTTON
func addBuyButton(self:SKScene){
    
    buyButton = SKSpriteNode(color: .white, size: CGSize(width: screenHeight/8, height:screenHeight/18))
    buyButton.position = CGPoint(x:0, y: backToGameButton.position.y + screenHeight/16)
    buyButton.texture = SKTexture(imageNamed: "buyButton")
    self.addChild(buyButton)
    
    
    let boxCostLabel = SKSpriteNode(color: .white, size: CGSize(width: screenHeight/8, height:screenHeight/32))
    boxCostLabel.position = CGPoint(x:0, y: buyButton.position.y + boxCostLabel.size.height + screenHeight/50)
    boxCostLabel.zPosition = buyButton.zPosition + 1
    boxCostLabel.texture = SKTexture(imageNamed: "boxCostLabel")
    self.addChild(boxCostLabel)
    
    
    
}

func addCrateImage(self:SKScene){
    crateImage = SKSpriteNode(color: .purple, size: CGSize(width: screenHeight/6, height: screenHeight/4))
    crateImage.position = CGPoint(x:0, y:screenHeight/20)
    crateImage.zPosition = crateImageZPosition
    crateImage.texture = SKTexture(imageNamed: "mysteryBox")
    
    
    crateImage2 = SKSpriteNode(color: .green, size: crateImage.size)
    crateImage2.position = crateImage.position
    crateImage2.zPosition = crateImageZPosition + 2
    crateImage2.texture = SKTexture(imageNamed: "mysteryBox2")
    
    self.addChild(crateImage)
    self.addChild(crateImage2)
}


//COINS LABEL
public var coinImageNode = SKSpriteNode()
func addCoinPurseText(self:SKScene, pos:CGPoint, fSize: CGFloat, alph:CGFloat){
    if userDefaults.value(forKey: UDKey.coinPurse) == nil{
        userDefaults.setValue(0, forKey: UDKey.coinPurse)
    }
    
    //coin number
    let coinPurse:Int = userDefaults.value(forKey: UDKey.coinPurse) as! Int
    displayedCoinPurse = SKLabelNode(text: String(coinPurse))
    displayedCoinPurse.fontSize = fSize
    displayedCoinPurse.fontColor = .black
    displayedCoinPurse.fontName = currentFont
    displayedCoinPurse.horizontalAlignmentMode = .left
    displayedCoinPurse.alpha = alph
    
    displayedCoinPurse.position = pos
    
    
    //coin image
    coinImageNode = SKSpriteNode(color: .white, size: CGSize(width: displayedCoinPurse.fontSize, height: displayedCoinPurse.fontSize))
    coinImageNode.position = CGPoint(x: pos.x - fSize/1.5, y: pos.y + fSize/2.65)
    coinImageNode.texture = SKTexture(imageNamed: "coin")
    coinImageNode.alpha = alph
    
    
    self.addChild(displayedCoinPurse)
    self.addChild(coinImageNode)
}


//MORECOMINGSOON

func checkAvailableSkins(self:SKScene){
    
    //check for nil
    if userDefaults.value(forKey: UDKey.inventory) == nil{
        userDefaults.setValue(["0"], forKey: UDKey.inventory)
    }
    
    let inv = userDefaults.value(forKey: UDKey.inventory) as! [String]
    
    //inv.count - 1 cuz default in inv
    if (Skins.common.count + Skins.epic.count == inv.count - 1){
        addMoreSkinsComingSoonBox(self: self)
        buyButtonAnimationActive = true
    }else{
        attemptPurchase(self: self)
    }
}

func addMoreSkinsComingSoonBox(self:SKScene){
    comingSoonBox = SKSpriteNode(color: .black, size: CGSize(width: screenHeight/5, height: screenHeight/4.5))
    comingSoonBox.position = CGPoint(x:0, y:screenHeight/100)
    comingSoonBox.alpha = 0
    comingSoonBox.texture = SKTexture(imageNamed: "comingSoon")
    comingSoonBox.zPosition = crateImage2.zPosition + 1
    
    self.addChild(comingSoonBox)
    
    comingSoonBox.run(SKAction.fadeIn(withDuration: 0.3))
    
    
}



