//
//  sounds.swift
//  boink
//
//  Created by Dylan Dang on 9/5/21.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit

//prep sound
func prepareSound(soundName:String, type:String, volume:Float, soundPlayer: inout AVAudioPlayer?) -> Void{
    let url = Bundle.main.url(forResource: soundName, withExtension: type)
    //if url empty return nothing
    guard url != nil else{
        return
    }
    
    //play
    do{
        soundPlayer = try AVAudioPlayer(contentsOf: url!)
        soundPlayer!.prepareToPlay()
        soundPlayer!.volume = volume
    }catch{
        print("SOUND PREP ERROR")
    }
}

//play sound
func playSound(soundPlayer: AVAudioPlayer?){
    if userDefaults.value(forKey: UDKey.volumeOn) as! Bool{
        DispatchQueue.background(delay: 0.0, background:{
            soundPlayer!.play()
        })
    }else{
        print("SOUND DID NOT PLAY")
    }
}

//for loading sounds
extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}



func setAudioSessionCategory(){
    do{
       try AVAudioSession.sharedInstance().setCategory(.ambient)
       try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    } catch {
       print("SOUND SHARED INSTANCE ERROR")
    }
}










//add volume button to scene
func addVolumeButton(self:SKScene){
    let diameter = screenHeight/50
    volumeButton = SKSpriteNode(color: .blue, size: CGSize(width: diameter, height: diameter))
    addVolumeButtonTexture()
    volumeButton.position = CGPoint(x: -screenWidth/4 + screenWidth/40, y: -screenHeight/4 + screenHeight/50)
    volumeButton.zPosition = menuBox.zPosition + 1
    
    self.addChild(volumeButton)
}

//for start gamescene
func addToggleVolumeBool(){
    if userDefaults.value(forKey: UDKey.volumeOn) == nil{
        userDefaults.setValue(true, forKey: UDKey.volumeOn)
    }
}

//on and off
func toggleVolume(){
    if userDefaults.value(forKey: UDKey.volumeOn) != nil{
        let value = userDefaults.value(forKey: UDKey.volumeOn) as! Bool
        if value{
            userDefaults.setValue(false, forKey: UDKey.volumeOn)
        }else{
            userDefaults.setValue(true, forKey: UDKey.volumeOn)
        }
        
    }else{
        userDefaults.setValue(true, forKey: UDKey.volumeOn)
    }
    
    addVolumeButtonTexture()
}


//change image
func addVolumeButtonTexture(){
    if userDefaults.value(forKey: UDKey.volumeOn) as! Bool{
        volumeButton.texture = SKTexture(imageNamed: "volumeOn")
    }else{
        volumeButton.texture = SKTexture(imageNamed: "volumeOff")
    }
}


