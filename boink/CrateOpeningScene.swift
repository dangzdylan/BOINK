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
        
        self.backgroundColor = shopBackgroundColor
        addWavyBackground(self: self)
    }
    

}
