//
//  GameViewController.swift
//  boink
//
//  Created by Dylan Dang on 8/20/21.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import GameKit

class GameViewController: UIViewController{ //, GKGameCenterControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //authPlayer()
        let scene = GameScene(fileNamed: "GameScene")!
        //print(view.bounds.size, screenWidth, screenHeight)
        let skView = view as! SKView
        
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        skView.allowsTransparency = true
        skView.backgroundColor = color(hex: "CDCACC")
        skView.showsPhysics = false
        
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        authenticateUser()
        gvc = self
        
    }
    
    
    private func authenticateUser(){
        let player = GKLocalPlayer.local
        
        player.authenticateHandler = {vc, error in
            
            
            guard error == nil else{
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let vc = vc{
                self.present(vc, animated: true, completion: nil)
            }
        
        }
    }

   
    
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}


extension UIViewController:
    GKGameCenterControllerDelegate{
    
    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
