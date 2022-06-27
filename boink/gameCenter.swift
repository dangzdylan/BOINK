//
//  gameCenter.swift
//  boink
//
//  Created by Dylan Dang on 1/12/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit



func showLeaderboards(self:UIViewController){
    leaderboardButton.texture = SKTexture(imageNamed: "leaderboardButton")
    let vc = GKGameCenterViewController()
    vc.gameCenterDelegate = self
    vc.viewState = .leaderboards
    vc.leaderboardIdentifier = leaderboardID
    self.present(vc, animated: true, completion: nil)
    
}


func addLeaderboardButton(self:SKScene){
    let diameter = screenHeight/30
    leaderboardButton = SKSpriteNode(color: .blue, size: CGSize(width: diameter, height: diameter))
    leaderboardButton.position = CGPoint(x:0, y: -screenHeight/9)
    leaderboardButton.texture = SKTexture(imageNamed: "leaderboardButton")
    
    self.addChild(leaderboardButton)
    
}

func determineRank(self:SKScene){
    
}



