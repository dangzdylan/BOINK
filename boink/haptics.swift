//
//  haptics.swift
//  boink
//
//  Created by Dylan Dang on 9/8/22.
//


import UIKit

func playImpactHaptic(type:UIImpactFeedbackGenerator.FeedbackStyle){
    let i = UIImpactFeedbackGenerator(style: type)
    i.prepare()
    i.impactOccurred()
}

func playNotifFeedback(type:UINotificationFeedbackGenerator.FeedbackType){
    let n = UINotificationFeedbackGenerator()
    n.prepare()
    n.notificationOccurred(type)
}


func pClickButtonHaptic(){
    playImpactHaptic(type: .light)
}

