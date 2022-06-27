//
//  InventoryScene.swift
//  boink
//
//  Created by Dylan Dang on 2/19/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit



class InventoryScene: SKScene{
    
    override func didMove(to view: SKView) {
        addBackToGameButton(self: self, pos: CGPoint(x: 0, y: -self.frame.height/2 + screenHeight/20))
        addInvNodes(self: self)
        getIndexOfEquippedSkin()
        addResetButton(self: self)
        //print(userDefaults.value(forKey: UDKey.inventory)!)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if !arrowAnimationOn{
                //back TEXTURE
                if backToGameButton.contains(location){
                    backToGameButton.texture = SKTexture(imageNamed: "clickedBackButton")
                    clicked.backButton = true
                    
                //right arrow TEXTURE
                }else if rightInventoryArrow.contains(location){
                    rightInventoryArrow.texture = SKTexture(imageNamed:"clickedRightArrow")
                    clicked.invRightArrow = true
                //left arrow TEXTURE
                }else if leftInventoryArrow.contains(location){
                    leftInventoryArrow.texture = SKTexture(imageNamed:"clickedLeftArrow")
                    clicked.invLeftArrow = true
                    
                //equip button
                }else if equipButton.contains(location){
                    equipButtonClicked()
                }
            }
            
            
            if resetButton.contains(location){
                resetStats(self: self)
            }
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            
            
            //back to game
            if backToGameButton.contains(location) && clicked.backButton{
                goBackToGameScene(self: self)
            
            //right arrow
            }else if rightInventoryArrow.contains(location) && clicked.invRightArrow{
                rightArrowClicked(self: self)
                
            //left arrow button
            }else if leftInventoryArrow.contains(location) && clicked.invLeftArrow{
                leftArrowClicked(self: self)
                
            }else{
                resetButtonTextures()
            }
            
            resetClickedButtons()
        }
    }
        
}
