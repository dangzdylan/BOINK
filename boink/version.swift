//
//  version.swift
//  boink
//
//  Created by Dylan Dang on 1/31/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit



func checkForAppUpdate(self:SKScene){
    
    var currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    if userDefaults.value(forKey: UDKey.currentAppVersion) == nil{
        //UserDefaults.value(forKey: UDKey.currentAppVersion) = currentVersion
    }
    
    
    
}
