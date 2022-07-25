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


func borderBackgroundTextures(ind:Int)-> SKTexture{
    return SKTexture(imageNamed: String(ind) + "borderBackground")
}

//0 = play area and font color; 1 = background color
public let backgroundColorWays:[Int: [String]] = [1 : ["FFFFFF", "CDCACC"],
                                                  2 : ["898076", "BAAEA1"],
                                                  3 : ["FBF8C9","F29B66"],
                                                  4 : ["9AA2E5", "2E1489"],
                                                  5 : ["F9E4D0", "9C3940"],
                                                  6 : ["315E26","7A9F79"],
                                                  7 : ["8ADCBD", "F0D3E0"],
                                                  8 : ["668586","93C6D6"],
                                                  9 : ["D9B8C4", "957186"],
                                                  10 : ["D6A5FA", "6B527D"],
                                                  11 : ["666666","E0D0C1"],
                                                  12 : ["B1DBC7", "4CA591"],
                                                  13 : ["FFF08D", "292205"],
                                            
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

