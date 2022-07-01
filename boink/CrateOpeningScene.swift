//
//  CrateOpeningScene.swift
//  boink
//
//  Created by Dylan Dang on 2/20/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit


class CrateOpeningScene: SKScene{
    override func didMove(to view: SKView) {
        self.backgroundColor = .gray
        addCrateImage(self: self)
        crateOpeningAnimation(self: self)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if backToGameButton.contains(location){
                clicked.backButton = true
                backToGameButton.texture = SKTexture(imageNamed: "clickedBackButton")
            }else if inventoryButton.contains(location){
                clicked.inventoryButton = true
                inventoryButton.texture = SKTexture(imageNamed: "clickedInventoryButton")
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if backToGameButton.contains(location) && clicked.backButton && backToGameButton.parent != nil{

                goBackToGameScene(self: self)
            }else if inventoryButton.contains(location) && clicked.inventoryButton && inventoryButton.parent != nil{
                
                goToInventory(self: self)
            }else{
                resetButtonTextures()
            }
            resetClickedButtons()
        }
    }
}
