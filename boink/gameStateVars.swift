//
//  gamestatevars.swift
//  boink
//
//  Created by Dylan Dang on 9/5/21.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit


//start labels
public var titleLabel = SKLabelNode()
public var tapToLabel = SKLabelNode()
public var startLabel = SKLabelNode()
public var gameHasStarted = false
public var titleLabelAnimationFinished = true
public var infoMenuActive = false
public var menuAnimationActive = false


//score
public var score  = SKLabelNode()
public var scoreNum = 0
public var spawnArrInd = 0
public var highScoreWordLabel = SKLabelNode()
public var addedHighScoreWordLabel = 1


//game Over vars
public var stopPlayerTextureMove = false
public var gameHasEnded = false
public var menuBox = SKSpriteNode()
public let menuBoxY:CGFloat = screenHeight
public var playAgain = SKSpriteNode()
public var scoreWordLabel = SKLabelNode()
public var scoreNumberLabel = SKLabelNode()
public var playAgainButtonActive = false

//data save
public let userDefaults = UserDefaults()

public struct UDKey{
    static let coinPurse = "coinPurse"
    static let highScore = "highScore"
    static let inventory = "inventory"
    static let playerTopRight = "playerTopRight"
    static let playerTopLeft = "playerTopLeft"
    static let playerBottomLeft = "playerBottomLeft"
    static let playerBottomRight = "playerBottomRight"
    static let playerLookDown = "playerLookDown"
    static let volumeOn = "volumeOn"
    static let currentAppVersion = "currentAppVersion"
    static let commonRemainingSkins = "commonRemainingSkins"
    static let rareRemainingSkins = "rareRemainingSkins"
    static let epicRemainingSkins = "epicRemainingSkins"
    static let legendaryRemainingSkins = "legendaryRemainingSkins"
    static let equippedSkin = "equippedSkin"
    
}

//sound var

public struct SPKey{
    static var collectCoinSoundPlayer: AVAudioPlayer?
    static var gameOverSoundPlayer: AVAudioPlayer?
    static var monsterSpawnSoundPlayer: AVAudioPlayer?
    static var menuSlideUpSoundPlayer: AVAudioPlayer?
    static var menuSlideDownSoundPlayer: AVAudioPlayer?
    static var titleStompSoundPlayer: AVAudioPlayer?
    static var monsterDispenseSoundPlayer: AVAudioPlayer?
    static var mysteryBoxShakeSoundPlayer: AVAudioPlayer?
    static var mysteryBoxDispenseSoundPlayer: AVAudioPlayer?
    static var chaching: AVAudioPlayer?
    static var mysteryPackageBreak: AVAudioPlayer?
    static var revealSkinMusic: AVAudioPlayer?
    static var epicRevealSkinMusic: AVAudioPlayer?
    static var buttonClick: AVAudioPlayer?
    static var equippedButtonClick: AVAudioPlayer?
    static var shopPurchaseFail: AVAudioPlayer?
}



//level
public var currentLevelLabel = SKLabelNode()


//font
public var currentFont = "BlueNight-Regular"

//game center leaderboards
public var gvc:UIViewController = UIViewController()
public var leaderboardButton = SKSpriteNode()
public let leaderboardID = "GlobalLeaderboard"


//flag vars
public var prevPlayerHitBorderTime = CGFloat(0)

//time
public var currentTimeFrame = CGFloat()



//click vars
public struct clicked{
    static var backButton = false
    static var invRightArrow = false
    static var invLeftArrow = false
    static var leaderboardButton = false
    static var inventoryButton = false
    static var shopButton = false
    static var buyButton = false
    static var equipButton = false
}

func resetClickedButtons(){
    clicked.backButton = false
    clicked.invRightArrow = false
    clicked.invLeftArrow = false
    clicked.leaderboardButton = false
    clicked.inventoryButton = false
    clicked.shopButton = false
    clicked.buyButton = false
    clicked.equipButton = false
}
