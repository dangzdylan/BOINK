//
//  reviewRequest.swift
//  boink
//
//  Created by Dylan Dang on 12/4/22.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit
import StoreKit


public var lastReviewRequest:Date?{
    get{
        return userDefaults.value(forKey: UDKey.lastReviewRequest) as? Date
    }
    set{
        userDefaults.set(newValue, forKey:UDKey.lastReviewRequest)
    }
}

public var oneWeekAgo: Date{
    return Calendar.current.date(byAdding: .day, value: -7, to: Date())!
}

public var shouldRequestReview:Bool{
    if lastReviewRequest == nil{
        return true
    }else if lastReviewRequest! < oneWeekAgo{
        return true
    }
    return false
}


func requestReview(){
    guard shouldRequestReview else { return }
    SKStoreReviewController.requestReview()
    lastReviewRequest = Date()
    
}
