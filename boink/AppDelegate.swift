//
//  AppDelegate.swift
//  boink
//
//  Created by Dylan Dang on 8/20/21.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import GameKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
        prepareSound(soundName:"collectCoin", type:"wav", volume:1, soundPlayer: &SPKey.collectCoinSoundPlayer)
        prepareSound(soundName:"gameOver", type:"wav", volume:1, soundPlayer: &SPKey.gameOverSoundPlayer)
        prepareSound(soundName: "menuSlide", type: "wav", volume: 1, soundPlayer: &SPKey.menuSlideUpSoundPlayer)
        prepareSound(soundName: "menuSlide", type: "wav", volume: 1, soundPlayer: &SPKey.menuSlideDownSoundPlayer)
        prepareSound(soundName: "titleStomp", type: "wav", volume: 0.8, soundPlayer: &SPKey.titleStompSoundPlayer)
        prepareSound(soundName: "monsterDispense", type: "wav", volume: 1, soundPlayer: &SPKey.monsterDispenseSoundPlayer)
        prepareSound(soundName: "mysteryBoxShaking", type: "wav", volume: 0.5, soundPlayer: &SPKey.mysteryBoxShakeSoundPlayer)
        prepareSound(soundName: "chaching", type: "wav", volume: 1, soundPlayer: &SPKey.chaching)
        prepareSound(soundName: "mysteryBoxDispense", type: "wav", volume: 0.8, soundPlayer: &SPKey.mysteryBoxDispenseSoundPlayer)
        prepareSound(soundName: "mysteryPackageBreak", type: "wav", volume: 1, soundPlayer: &SPKey.mysteryPackageBreak)
        prepareSound(soundName: "revealSkinMusic", type: "wav", volume: 1.1, soundPlayer: &SPKey.revealSkinMusic)
        prepareSound(soundName: "buttonClick", type: "wav", volume: 0.7, soundPlayer: &SPKey.buttonClick)
        prepareSound(soundName: "equippedButtonClick", type: "wav", volume: 0.8, soundPlayer: &SPKey.equippedButtonClick)
        prepareSound(soundName: "epicRevealSkinMusic", type: "wav", volume: 1.1, soundPlayer: &SPKey.epicRevealSkinMusic)
        prepareSound(soundName: "shopPurchaseFail", type: "wav", volume: 0.8, soundPlayer: &SPKey.shopPurchaseFail)
        
        return true
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    
    
    

}

