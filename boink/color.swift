//
//  color.swift
//  boink
//
//  Created by Dylan Dang on 10/24/21.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit

//0 = play area and font color; 1 = background color

public let borderBackgroundTextures:[SKTexture] = [SKTexture(), SKTexture(imageNamed: "1borderBackground"), SKTexture(imageNamed: "2borderBackground"), SKTexture(imageNamed: "3borderBackground"), SKTexture(imageNamed: "4borderBackground"), SKTexture(imageNamed: "5borderBackground"), SKTexture(imageNamed: "6borderBackground"), SKTexture(imageNamed: "7borderBackground"), SKTexture(imageNamed: "8borderBackground"), SKTexture(imageNamed: "9borderBackground"), SKTexture(imageNamed: "10borderBackground"), SKTexture(imageNamed: "11borderBackground")]

public let backgroundColorWays:[Int: [String]] = [1 : ["FFFFFF", "CDCACC"],
                          8 : ["668586","93C6D6"],
                          7 : ["8ADCBD", "F0D3E0"],
                          5 : ["F9E4D0", "9C3940"],
                          4 : ["9AA2E5", "2E1489"],
                        9 : ["D9B8C4", "957186"],
                        2 : ["898076", "BAAEA1"],
                        3 : ["FBF8C9","F29B66"],
                        6 : ["315E26","7A9F79"],
                        11 : ["010000","CDCACC"],
                        10 : ["D6A5FA", "6B527D"]
                                            
]
public var textBorderColor = color(hex: "FFFFFF")



public struct backColor{
    static let common = shopBackgroundColor
    static let goldenDefault = color(hex: "FDE17B")
}









func color(hex:String) -> UIColor{
    
    //r,g,b
    var colorArr:[CGFloat] = [0,0,0]
    var colorArrInd = 0
    var currentInd = 0
    
    for var color in colorArr{
        let index1 = hex.index(hex.startIndex, offsetBy: currentInd)
        if hex[index1].isNumber{
            color += CGFloat(hex[index1].wholeNumberValue! * 16)
        }else{
            color += CGFloat((hex[index1].asciiValue! - 55) * 16)
        }
        
        let index2 = hex.index(hex.startIndex, offsetBy: currentInd + 1)
        if hex[index2].isNumber{
            color += CGFloat(hex[index2].wholeNumberValue!)
        }else{
            color += CGFloat(hex[index2].asciiValue! - 55)
        }
        
        colorArr[colorArrInd] = color
        colorArrInd += 1
        currentInd += 2
    }
    
    return UIColor(red: colorArr[0]/255, green: colorArr[1]/255, blue: colorArr[2]/255, alpha: 1)
}



func setBackground(self:SKScene, chosenColor:[String], borderBackgroundtext:SKTexture){
    
    textBorderColor = color(hex: chosenColor[0])
    self.backgroundColor = color(hex: chosenColor[1])
    
    
    //change border & text color
    let borderArr = [leftBorder, rightBorder, topBorder, bottomBorder]
    
    score.fontColor = textBorderColor
    highScoreWordLabel.fontColor = textBorderColor
    
    for border in borderArr{
        border.strokeColor = self.backgroundColor
    }
    borderBackground.texture = borderBackgroundtext
    
  
}

