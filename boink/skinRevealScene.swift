//
//  skinReveal.swift
//  boink
//
//  Created by Dylan Dang on 6/30/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit


class SkinRevealScene: SKScene{
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .gray
        addChosenSkin(self: self)
        
        self.backgroundColor = currentUnboxedSkin.background
        addWavyBackground(self: self)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if backToGameButton.contains(location) && Int(backToGameButton.alpha) == 1{
                clicked.backButton = true
                backToGameButton.texture = SKTexture(imageNamed: "clickedBackButton")
            }else if inventoryButton.contains(location) && Int(inventoryButton.alpha) == 1{
                clicked.inventoryButton = true
                inventoryButton.texture = SKTexture(imageNamed: "clickedInventoryButton")
            }else if equipButton.contains(location) && Int(equipButton.alpha) == 1{
                clicked.equipButton = true
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
            }else if equipButton.contains(location) && clicked.equipButton && equipButton.parent != nil{
                let inv = userDefaults.value(forKey: UDKey.inventory) as! [String]
                currentSkinInd = inv.count - 1
                equipButtonClicked()
            }else{
                resetButtonTextures()
            }
            resetClickedButtons()
        }
    }
    
    
    
}
