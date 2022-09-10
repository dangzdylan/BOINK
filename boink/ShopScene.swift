//
//  ShopScene.swift
//  boink
//
//  Created by Dylan Dang on 2/19/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit



class ShopScene : SKScene{
    
    override func didMove(to view: SKView) {
        addCoinPurseText(self: self)
        addCrateImage(self: self)
        addBackToGameButton(self: self, pos: CGPoint(x: 0, y: -self.frame.height/2 + screenHeight/20), diameter: screenHeight / 25)
        addBuyButton(self: self)
        
        self.backgroundColor = shopBackgroundColor
        addWavyBackground(self: self)
    
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            //back button clicked texture
            if backToGameButton.contains(location){
                pClickButtonHaptic()
                backToGameButton.texture = SKTexture(imageNamed: "clickedBackButton")
                clicked.backButton = true
            }
            
            //purchase clicked texture
            if buyButton.contains(location) && !buyButtonAnimationActive{
                pClickButtonHaptic()
                buyButton.texture = SKTexture(imageNamed: "clickedBuyButton")
                clicked.buyButton = true
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            //go back to Game
            if backToGameButton.contains(location) && clicked.backButton{
                buyButtonAnimationActive = false
                goBackToGameScene(self: self)
            
            //purchase 
            }else if buyButton.contains(location) && !buyButtonAnimationActive && clicked.buyButton{
                checkAvailableSkins(self: self)
            }else{
                resetButtonTextures()
            }
            resetClickedButtons()
            
        }
    }
}
