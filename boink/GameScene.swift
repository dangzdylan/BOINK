//
//  GameScene.swift
//  boink
//
//  Created by Dylan Dang on 8/20/21.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        
        
        addBorders(self:self)
        setBackground(self: self, chosenColor:backgroundColorWays[1]!, borderBackgroundtext: borderBackgroundTextures[1])
        self.physicsWorld.contactDelegate = self
        
        
        
        gameHasStarted = false
        addStartLabels(self: self)
        equipSkinAtStart()
        addPlayer(self:self)
        addCoinObject(self: self)
        addSpawner(self: self)
        addHighScore(self: self)
        addInfoButton(self: self)
        addToggleVolumeBool()
        addVolumeButton(self: self)
        addLeaderboardButton(self: self)
        addShopButton(self: self)
        addInventoryButton(self: self, pos: CGPoint(x: leaderboardButton.position.x - screenHeight/18, y: leaderboardButton.position.y), diameter: screenHeight / 30)

        determineRank(self:self)
        
        if replayButtonHasBeenClicked{
            callStartFuncs(self: self)
        }
        
        
        
        
        

    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !gameHasStarted && titleLabelAnimationFinished{
            for touch in touches{
                let location = touch.location(in: self)
                
                if volumeButton.contains(location){
                    toggleVolume()
                
                //press info button
                }else if infoMenuActive{
                        //add back info button and exit menu
                        infoMenuExit(self: self)
                }else if infoButton.contains(location){
                    addInfoMenu(self: self)
                    
                //CHECK ALL THREE BUTTONS
                }else if leaderboardButton.contains(location){
                    leaderboardButton.texture = SKTexture(imageNamed: "clickedLeaderboardButton")
                    clicked.leaderboardButton = true
                    
                }else if shopButton.contains(location){
                    shopButton.texture = SKTexture(imageNamed: "clickedShopButton")
                    clicked.shopButton = true
                    
                }else if inventoryButton.contains(location){
                    inventoryButton.texture = SKTexture(imageNamed: "clickedInventoryButton")
                    clicked.inventoryButton = true
                    
    
                //START GAME
                }else if !infoMenuActive{
                    callStartFuncs(self: self)
                }
                
            }
        }else if titleLabelAnimationFinished && !stopPlayerTextureMove && !infoMenuActive{
            movePlayer(self:self)
        }
        
        //call game menu if game has ended
        if gameHasEnded{
            for touch in touches{
                let location = touch.location(in: self)
                if playAgain.contains(location) && playAgainButtonActive{
                    
                    clicked.playAgainButton = true
                    playAgain.texture = SKTexture(imageNamed: "clickedReplayButton")
                    
                }else if backToHomeButton.contains(location) && playAgainButtonActive{
                    
                    clicked.backToHomeButton = true
                    backToHomeButton.texture = SKTexture(imageNamed: "clickedMenuHomeButton")
                    
                }
            
            }
        }
        
        
    }
    
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if !gameHasStarted{
                if inventoryButton.contains(location) && clicked.inventoryButton{
                   
                    goToInventory(self: self)
                
                //shop
                }else if shopButton.contains(location) && clicked.shopButton{
                    
                    goToShop(self: self)
                    
                //leaderboards
                } else if leaderboardButton.contains(location) && clicked.leaderboardButton{
                    
                    playSound(soundPlayer: SPKey.buttonClick)
                    showLeaderboards(self: gvc)
                    
                
                }else{
                    resetButtonTextures()
                }
            //replay button
            }else if gameHasEnded && !menuAnimationActive{
                if playAgain.contains(location) && clicked.playAgainButton{
                    replayButtonClicked(self: self)
                }else if backToHomeButton.contains(location) && clicked.backToHomeButton{
                    menuHomeButtonClicked(self: self)
                }else{
                    resetButtonTextures()
                }
            }else{
                resetButtonTextures()
            }
            
            resetClickedButtons()
            
        }
    }
    
    
    
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        
        //rotate player texture and change direction
        if collision == ColliderType.Player | ColliderType.topBorder{
            PlayerTouchBorder(borderBit: ColliderType.topBorder)
        } else if collision == ColliderType.Player | ColliderType.bottomBorder{
            PlayerTouchBorder(borderBit: ColliderType.bottomBorder)
        } else if collision == ColliderType.Player | ColliderType.rightBorder{
            PlayerTouchBorder(borderBit: ColliderType.rightBorder)
        } else if collision == ColliderType.Player | ColliderType.leftBorder{
            PlayerTouchBorder(borderBit: ColliderType.leftBorder)
        }
        
        //ensure monster is body A
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        if bodyB.categoryBitMask == ColliderType.Monster{
            bodyA = contact.bodyB
            bodyB = contact.bodyA
        }
        
        //monster vs borders
        if bodyA.categoryBitMask == ColliderType.Monster{
            monsterMovement(bodyA:bodyA, collision:collision)
        }
        
        //player vs monster
        if collision == ColliderType.Player | ColliderType.Monster && !gameHasEnded{
            
            gameOverAnimation(self:self)
            
            //game over
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false){timer in
                gameOver(self: self)
                
            }
        }
        //player vs coin
        if collision == ColliderType.Player | ColliderType.coin{
            touchCoin(self:self)
        }
        
        
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        currentTimeFrame = CGFloat(currentTime)
    }
    
}


    




